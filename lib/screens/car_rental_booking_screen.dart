import 'package:flutter/material.dart';
import 'constants.dart';
import 'car_rental_payment_screen.dart';
import 'car_rental_listing_screen.dart';

class CarRentalBookingScreen extends StatefulWidget {
  final CarListing car;

  const CarRentalBookingScreen({super.key, required this.car});

  @override
  State<CarRentalBookingScreen> createState() =>
      _CarRentalBookingScreenState();
}

class _CarRentalBookingScreenState
    extends State<CarRentalBookingScreen> {
  DateTime? _startDate;
  DateTime? _endDate;

  int get _totalDays {
    if (_startDate == null || _endDate == null) return 0;
    return _endDate!.difference(_startDate!).inDays;
  }

  double get _totalPrice => _totalDays * widget.car.pricePerDay;

  bool get _isFormValid =>
      _startDate != null && _endDate != null && _totalDays > 0;

  String _formatDate(DateTime? date) {
    if (date == null) return "Select date";
    return "${date.day.toString().padLeft(2, '0')} "
        "${_monthName(date.month)} ${date.year}";
  }

  String _monthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }

  Future<void> _pickStartDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
      helpText: "Select pickup date",
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
              primary: AppColors.brandBlue),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        // Reset end date if it's before start date
        if (_endDate != null &&
            _endDate!.isBefore(picked.add(const Duration(days: 1)))) {
          _endDate = null;
        }
      });
    }
  }

  Future<void> _pickEndDate() async {
    if (_startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please select pickup date first")),
      );
      return;
    }
    final minEnd = _startDate!.add(const Duration(days: 1));
    final picked = await showDatePicker(
      context: context,
      initialDate: minEnd,
      firstDate: minEnd,
      lastDate: DateTime(_startDate!.year + 1),
      helpText: "Select return date",
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
              primary: AppColors.brandBlue),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _endDate = picked);
  }

  void _onBook() {
    if (!_isFormValid) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CarRentalPaymentScreen(
          car: widget.car,
          startDate: _startDate!,
          endDate: _endDate!,
          totalDays: _totalDays,
          totalPrice: _totalPrice,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Book Vehicle",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Car info card ───────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.brandBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.directions_car,
                      color: AppColors.brandBlue,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.car.model,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          "${widget.car.category} · ${widget.car.plate}",
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                size: 12, color: AppColors.gold),
                            const SizedBox(width: 2),
                            Text(
                              "${widget.car.rating}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "RM ${widget.car.pricePerDay.toStringAsFixed(0)}/day",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.brandBlue,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              "Select Rental Dates",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 16),

            // ── Date pickers ──────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _DatePickerBox(
                    label: "Pickup Date",
                    value: _formatDate(_startDate),
                    icon: Icons.calendar_today,
                    onTap: _pickStartDate,
                    isSelected: _startDate != null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DatePickerBox(
                    label: "Return Date",
                    value: _formatDate(_endDate),
                    icon: Icons.event_available,
                    onTap: _pickEndDate,
                    isSelected: _endDate != null,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Price breakdown ───────────────────────────────────────
            if (_totalDays > 0) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    _PriceRow(
                      label:
                          "RM ${widget.car.pricePerDay.toStringAsFixed(0)} × $_totalDays days",
                      value:
                          "RM ${_totalPrice.toStringAsFixed(2)}",
                    ),
                    const Divider(height: 20),
                    _PriceRow(
                      label: "Total",
                      value:
                          "RM ${_totalPrice.toStringAsFixed(2)}",
                      isBold: true,
                      valueColor: AppColors.brandBlue,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],

            // ── Book button ───────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandBlue,
                  disabledBackgroundColor:
                      AppColors.brandBlue.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _isFormValid ? _onBook : null,
                child: Text(
                  _isFormValid
                      ? "Book for RM ${_totalPrice.toStringAsFixed(2)}"
                      : "Select dates to continue",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DatePickerBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  const _DatePickerBox({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.brandBlue.withOpacity(0.06)
              : AppColors.inputFill,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.brandBlue
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  icon,
                  size: 14,
                  color: isSelected
                      ? AppColors.brandBlue
                      : AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected
                          ? AppColors.brandBlue
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const _PriceRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight:
                isBold ? FontWeight.bold : FontWeight.normal,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight:
                isBold ? FontWeight.bold : FontWeight.normal,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}