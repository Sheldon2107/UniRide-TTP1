import 'package:flutter/material.dart';

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
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004687),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

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
}