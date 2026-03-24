import 'dart:async';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'car_rental_return_screen.dart';
import 'car_rental_listing_screen.dart';

class CarRentalActiveRentalScreen extends StatefulWidget {
  final CarListing car;
  final DateTime startDate;
  final DateTime endDate;
  final int totalDays;
  final double totalPrice;

  const CarRentalActiveRentalScreen({
    super.key,
    required this.car,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.totalPrice,
  });

  @override
  State<CarRentalActiveRentalScreen> createState() =>
      _CarRentalActiveRentalScreenState();
}

class _CarRentalActiveRentalScreenState
    extends State<CarRentalActiveRentalScreen> {
  late Timer _timer;
  late Duration _timeRemaining;

  @override
  void initState() {
    super.initState();
    _timeRemaining =
        widget.endDate.difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      final remaining =
          widget.endDate.difference(DateTime.now());
      if (remaining.isNegative) {
        _timer.cancel();
        setState(() => _timeRemaining = Duration.zero);
      } else {
        setState(() => _timeRemaining = remaining);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return "${date.day} ${months[date.month - 1]} ${date.year}";
  }

  String get _timeRemainingLabel {
    if (_timeRemaining == Duration.zero) return "Rental period ended";
    final days = _timeRemaining.inDays;
    final hours = _timeRemaining.inHours % 24;
    final minutes = _timeRemaining.inMinutes % 60;
    if (days > 0) return "$days days $hours hrs remaining";
    if (hours > 0) return "$hours hrs $minutes min remaining";
    return "${_timeRemaining.inMinutes} min remaining";
  }

  double get _progressValue {
    final total = widget.endDate
        .difference(widget.startDate)
        .inSeconds
        .toDouble();
    final elapsed = DateTime.now()
        .difference(widget.startDate)
        .inSeconds
        .toDouble();
    return (elapsed / total).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          "Active Rental",
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
            // ── Status banner ──────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.success,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.directions_car,
                    color: Colors.white,
                    size: 36,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Rental Active",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _timeRemainingLabel,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Progress bar ───────────────────────────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDate(widget.startDate),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      _formatDate(widget.endDate),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: _progressValue,
                    minHeight: 8,
                    backgroundColor: Colors.grey[200],
                    color: AppColors.brandBlue,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Car details ────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _DetailRow(
                      label: "Vehicle",
                      value: widget.car.model),
                  const SizedBox(height: 8),
                  _DetailRow(
                      label: "Plate",
                      value: widget.car.plate),
                  const SizedBox(height: 8),
                  _DetailRow(
                      label: "Owner",
                      value: widget.car.ownerName),
                  const SizedBox(height: 8),
                  _DetailRow(
                      label: "Duration",
                      value: "${widget.totalDays} days"),
                  const SizedBox(height: 8),
                  _DetailRow(
                    label: "Total Paid",
                    value:
                        "RM ${widget.totalPrice.toStringAsFixed(2)}",
                    valueColor: AppColors.brandBlue,
                    isBold: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ── Return button ──────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CarRentalReturnScreen(
                      car: widget.car,
                      totalPrice: widget.totalPrice,
                    ),
                  ),
                ),
                child: const Text(
                  "Return Vehicle",
                  style: TextStyle(
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

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const _DetailRow({
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
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}