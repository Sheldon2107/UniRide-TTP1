import 'package:flutter/material.dart';
import 'constants.dart';
import 'car_rental_active_rental_screen.dart';
import 'car_rental_listing_screen.dart';

class CarRentalPaymentScreen extends StatefulWidget {
  final CarListing car;
  final DateTime startDate;
  final DateTime endDate;
  final int totalDays;
  final double totalPrice;

  const CarRentalPaymentScreen({
    super.key,
    required this.car,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.totalPrice,
  });

  @override
  State<CarRentalPaymentScreen> createState() =>
      _CarRentalPaymentScreenState();
}

class _CarRentalPaymentScreenState
    extends State<CarRentalPaymentScreen> {
  int _selectedPayment = 0;
  bool _isLoading = false;

  static const List<_PaymentOption> _paymentOptions = [
    _PaymentOption(
      label: "Roadway Cash",
      subtitle: "Balance: RM 50.00",
      icon: Icons.account_balance_wallet_outlined,
    ),
    _PaymentOption(
      label: "Online Banking",
      subtitle: "FPX, Maybank, CIMB...",
      icon: Icons.account_balance_outlined,
    ),
    _PaymentOption(
      label: "Pay with Cash",
      subtitle: "Pay owner directly",
      icon: Icons.payments_outlined,
    ),
  ];

  String _formatDate(DateTime date) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return "${date.day} ${months[date.month - 1]} ${date.year}";
  }

  Future<void> _onConfirmPayment() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => CarRentalActiveRentalScreen(
          car: widget.car,
          startDate: widget.startDate,
          endDate: widget.endDate,
          totalDays: widget.totalDays,
          totalPrice: widget.totalPrice,
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
          "Payment",
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
            // ── Booking summary ────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Booking Summary",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 8),
                  _SummaryRow(
                    label: "Vehicle",
                    value: widget.car.model,
                  ),
                  const SizedBox(height: 8),
                  _SummaryRow(
                    label: "Pickup",
                    value: _formatDate(widget.startDate),
                  ),
                  const SizedBox(height: 8),
                  _SummaryRow(
                    label: "Return",
                    value: _formatDate(widget.endDate),
                  ),
                  const SizedBox(height: 8),
                  _SummaryRow(
                    label: "Duration",
                    value: "${widget.totalDays} days",
                  ),
                  const SizedBox(height: 8),
                  _SummaryRow(
                    label: "Total",
                    value:
                        "RM ${widget.totalPrice.toStringAsFixed(2)}",
                    isBold: true,
                    valueColor: AppColors.brandBlue,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              "Payment Method",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 16),

            // ── Payment options ────────────────────────────────────────
            ...List.generate(_paymentOptions.length, (index) {
              final option = _paymentOptions[index];
              final bool selected = _selectedPayment == index;
              return GestureDetector(
                onTap: () =>
                    setState(() => _selectedPayment = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.brandBlue.withOpacity(0.06)
                        : AppColors.inputFill,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected
                          ? AppColors.brandBlue
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        option.icon,
                        color: selected
                            ? AppColors.brandBlue
                            : AppColors.textSecondary,
                        size: 24,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              option.label,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: selected
                                    ? AppColors.brandBlue
                                    : AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              option.subtitle,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (selected)
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.brandBlue,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),

            // ── Confirm button ─────────────────────────────────────────
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
                onPressed: _isLoading ? null : _onConfirmPayment,
                child: _isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Text(
                        "Pay RM ${widget.totalPrice.toStringAsFixed(2)}",
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

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const _SummaryRow({
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
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight:
                isBold ? FontWeight.bold : FontWeight.w500,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _PaymentOption {
  final String label;
  final String subtitle;
  final IconData icon;

  const _PaymentOption({
    required this.label,
    required this.subtitle,
    required this.icon,
  });
}