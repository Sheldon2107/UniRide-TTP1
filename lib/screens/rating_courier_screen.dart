import 'package:flutter/material.dart';
import 'constants.dart';

class RatingCourierScreen extends StatefulWidget {
  final String courierName;
  final String courierPrice;

  const RatingCourierScreen({
    super.key,
    required this.courierName,
    required this.courierPrice,
  });

  @override
  State<RatingCourierScreen> createState() => _RatingCourierScreenState();
}

class _RatingCourierScreenState extends State<RatingCourierScreen> {
  int _rating = 4;
  final Set<String> _selectedTags = {"On time"};

  static const List<String> _positiveTags = [
    "On time",
    "Handled with care",
    "Friendly",
    "Fast delivery",
  ];

  static const List<String> _negativeTags = [
    "Poor Route",
    "Too many pickups",
    "Late delivery",
    "Navigation issues",
    "Damaged package",
    "Other",
  ];

  String get _ratingLabel => switch (_rating) {
        1 => "Terrible",
        2 => "Bad",
        3 => "Okay",
        4 => "Good",
        5 => "Excellent",
        _ => "",
      };

  // Show positive tags for 4-5 stars, negative for 1-3
  List<String> get _activeTags =>
      _rating >= 4 ? _positiveTags : _negativeTags;

  String get _tagSectionLabel =>
      _rating >= 4 ? "What went well?" : "What went wrong?";

  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  void _onRatingChanged(int newRating) {
    setState(() {
      _rating = newRating;
      _selectedTags.clear(); // reset tags when rating changes
    });
  }

  void _submit() {
    if (!mounted) return;
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final double chipWidth = MediaQuery.of(context).size.width * 0.4;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Rate Courier",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ── Courier info ─────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.brandBlue.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.brandBlue.withOpacity(0.15),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.brandBlue.withOpacity(0.1),
                    child: const Icon(
                      Icons.person,
                      color: AppColors.brandBlue,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.courierName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Text(
                          "Your courier",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    widget.courierPrice,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.brandBlue,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ── Star rating ──────────────────────────────────────────
            Text(
              _ratingLabel,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final bool filled = index < _rating;
                return IconButton(
                  icon: Icon(
                    filled ? Icons.star : Icons.star_border,
                    color: filled
                        ? AppColors.brandBlue
                        : Colors.grey[300],
                    size: 36,
                  ),
                  onPressed: () => _onRatingChanged(index + 1),
                );
              }),
            ),

            const Divider(height: 40),

            // ── Tag selection ────────────────────────────────────────
            Text(
              _tagSectionLabel,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: _activeTags.map((tag) {
                final bool isSelected = _selectedTags.contains(tag);
                return SizedBox(
                  width: chipWidth,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: isSelected
                          ? AppColors.brandBlue
                          : AppColors.brandBlue.withOpacity(0.06),
                      foregroundColor: isSelected
                          ? Colors.white
                          : AppColors.textPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.brandBlue
                              : AppColors.brandBlue.withOpacity(0.2),
                        ),
                      ),
                    ),
                    onPressed: () => _toggleTag(tag),
                    child: Text(
                      tag,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Text(
              "Select one or more.",
              style: TextStyle(
                color: AppColors.textSecondary.withOpacity(0.7),
                fontSize: 13,
              ),
            ),

            const Spacer(),

            // ── Submit button ────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedTags.isNotEmpty
                      ? AppColors.brandBlue
                      : AppColors.brandBlue.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                onPressed: _selectedTags.isNotEmpty ? _submit : null,
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}