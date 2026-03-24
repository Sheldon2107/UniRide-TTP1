import 'package:flutter/material.dart';
import 'constants.dart';
import 'home_dashboard.dart';
import 'car_rental_listing_screen.dart';

class CarRentalRatingScreen extends StatefulWidget {
  final CarListing car;
  final double totalPrice;

  const CarRentalRatingScreen({
    super.key,
    required this.car,
    required this.totalPrice,
  });

  @override
  State<CarRentalRatingScreen> createState() =>
      _CarRentalRatingScreenState();
}

class _CarRentalRatingScreenState
    extends State<CarRentalRatingScreen> {
  int _rating = 0;
  final Set<String> _selectedTags = {};

  static const List<String> _tags = [
    "Clean vehicle",
    "Well maintained",
    "Good communication",
    "On time",
    "As described",
    "Would rent again",
    "Minor issues",
    "Late pickup",
    "Needs cleaning",
  ];

  String get _ratingLabel => switch (_rating) {
        1 => "Poor",
        2 => "Below Average",
        3 => "Okay",
        4 => "Good",
        5 => "Excellent!",
        _ => "How was the vehicle?",
      };

  void _onSubmit() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeDashboard()),
      (route) => false,
    );
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
          "Rate Your Experience",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),

            // ── Car info ───────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.brandBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.directions_car,
                        color: AppColors.brandBlue, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.car.model,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          "Owner: ${widget.car.ownerName}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "RM ${widget.totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.brandBlue,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Rating label ───────────────────────────────────────────
            Text(
              _ratingLabel,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 12),

            // ── Stars ──────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final bool filled = index < _rating;
                return IconButton(
                  icon: Icon(
                    filled ? Icons.star : Icons.star_border,
                    color: filled ? AppColors.gold : Colors.grey[300],
                    size: 40,
                  ),
                  onPressed: () =>
                      setState(() => _rating = index + 1),
                );
              }),
            ),

            const SizedBox(height: 20),

            // ── Tags ───────────────────────────────────────────────────
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: _tags.map((tag) {
                final bool selected = _selectedTags.contains(tag);
                return GestureDetector(
                  onTap: () => setState(() {
                    if (selected) {
                      _selectedTags.remove(tag);
                    } else {
                      _selectedTags.add(tag);
                    }
                  }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.brandBlue
                          : AppColors.inputFill,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 12,
                        color: selected
                            ? Colors.white
                            : AppColors.textPrimary,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const Spacer(),

            // ── Submit ─────────────────────────────────────────────────
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
                onPressed: _rating > 0 ? _onSubmit : null,
                child: const Text(
                  "Submit Review",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
