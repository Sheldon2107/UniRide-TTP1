import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'constants.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _rating = 0;
  final Set<String> _selectedIssues = {};

  static const List<String> _issues = [
    "Poor Route",
    "Too many Pickups",
    "Co-rider behavior",
    "Navigation",
    "Driving",
    "Other",
  ];

  String get _ratingLabel => switch (_rating) {
        1 => "Terrible",
        2 => "Bad",
        3 => "Okay",
        4 => "Good",
        5 => "Excellent",
        _ => "How was your ride?",
      };

  void _toggleIssue(String issue) {
    setState(() {
      if (_selectedIssues.contains(issue)) {
        _selectedIssues.remove(issue);
      } else {
        _selectedIssues.add(issue);
      }
    });
  }

  void _onSubmit() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Rate Your Trip",
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
            const SizedBox(height: 20),

            // ── Rating label ──────────────────────────────────────────
            Text(
              _ratingLabel,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 20),

            // ── Stars ─────────────────────────────────────────────────
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
                  onPressed: () =>
                      setState(() => _rating = index + 1),
                );
              }),
            ),

            const SizedBox(height: 30),

            // ── Issue chips ───────────────────────────────────────────
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _issues.map((issue) {
                final bool selected = _selectedIssues.contains(issue);
                return GestureDetector(
                  onTap: () => _toggleIssue(issue),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.brandBlue
                          : AppColors.inputFill,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      issue,
                      style: TextStyle(
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

            const SizedBox(height: 16),

            const Text(
              "Please select one or more issues.",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),

            const Spacer(),

            // ── Submit button ─────────────────────────────────────────
=======

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Rating", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text("Good", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            // Star Rating Row
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.black, size: 36),
                Icon(Icons.star, color: Colors.black, size: 36),
                Icon(Icons.star, color: Colors.black, size: 36),
                Icon(Icons.star, color: Colors.black, size: 36),
                Icon(Icons.star_border, color: Colors.grey, size: 36),
              ],
            ),
            const SizedBox(height: 40),
            const Text("What went wrong?", style: TextStyle(fontSize: 16, color: Colors.black87)),
            const SizedBox(height: 20),
            // Issue Chips
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                _issueChip("Poor Route"),
                _issueChip("Too many Pickups", isSelected: true),
                _issueChip("Co-rider behavior"),
                _issueChip("Navigation"),
                _issueChip("Driving"),
                _issueChip("Other"),
              ],
            ),
            const SizedBox(height: 30),
            const Text("Please Select one or more issues.", style: TextStyle(color: Colors.grey)),
            const Spacer(),
            // Submit Button
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                  backgroundColor: AppColors.brandBlue,
                  disabledBackgroundColor:
                      AppColors.brandBlue.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _rating > 0 ? _onSubmit : null,
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
=======
                  backgroundColor: const Color(0xFF004687),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 40),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
=======

  Widget _issueChip(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF004687) : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontSize: 13),
      ),
    );
  }
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
}