import 'package:flutter/material.dart';

class RatingCourierScreen extends StatefulWidget {
  const RatingCourierScreen({super.key});

  @override
  State<RatingCourierScreen> createState() => _RatingCourierScreenState();
}

class _RatingCourierScreenState extends State<RatingCourierScreen> {
  int _rating = 4; // Matches the 4-star "Good" state
  final List<String> _selectedIssues = ["Too many Pickups"]; // Pre-selected issue

  final List<String> _issues = [
    "Poor Route",
    "Too many Pickups",
    "Co-rider behavior",
    "Navigation",
    "Driving",
    "Other"
  ];

  void _toggleIssue(String issue) {
    setState(() {
      if (_selectedIssues.contains(issue)) {
        _selectedIssues.remove(issue);
      } else {
        _selectedIssues.add(issue);
      }
    });
  }

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
        centerTitle: true,
        title: const Text(
          "Rating",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text("Good", style: TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 10),
            
            // Star Rating Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: index < _rating ? Colors.black : Colors.grey[300],
                    size: 32,
                  ),
                  onPressed: () => setState(() => _rating = index + 1),
                );
              }),
            ),
            
            const Divider(height: 40),
            const Text(
              "What went wrong?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),

            // Issue Selection Wrap
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: _issues.map((issue) {
                bool isSelected = _selectedIssues.contains(issue);
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: isSelected ? const Color(0xFF004687) : Colors.grey[100],
                      foregroundColor: isSelected ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => _toggleIssue(issue),
                    child: Text(issue, style: const TextStyle(fontSize: 12)),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),
            const Text(
              "Please Select one or more issues.",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),

            const Spacer(),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004687),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Returns the user to the very first screen (Home)
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      // Persistent Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Account"),
        ],
      ),
    );
  }
}