import 'package:flutter/material.dart';
import 'rating_screen.dart'; // Ensure this file is created

class ArrivedScreen extends StatelessWidget {
  const ArrivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. DARK MODE MAP BACKGROUND
          Container(
            color: const Color(0xFF1A1C1E),
            child: const Center(
              child: Text(
                "Map: Trip Completed",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),

          // 2. TOP NAVIGATION (Back Button Fix)
          // Fixed 'elevation' error by using Material widget
          Positioned(
            top: 50,
            left: 20,
            child: Material(
              elevation: 4,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              color: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // 3. ARRIVED STATUS SHEET
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pull Handle
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 25),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  // TRIP SUMMARY (V4 CAFE to CHANCELLOR HALL)
                  _buildTripNode(Icons.circle_outlined, "V4 CAFE", isTop: true),

                  // Vertical line connector
                  const Padding(
                    padding: EdgeInsets.only(left: 7),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 30,
                        child: VerticalDivider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  _buildTripNode(Icons.stop, "CHANCELLOR HALL", isTop: false),

                  const SizedBox(height: 40),

                  // FINAL ARRIVED BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004687), // Uni-RIDE Blue
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Navigates to the Rating Screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RatingScreen()),
                        );
                      },
                      child: const Text(
                        "Arrived !",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build the location rows
  Widget _buildTripNode(IconData icon, String location, {required bool isTop}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: isTop ? Colors.grey[700] : Colors.black,
        ),
        const SizedBox(width: 15),
        Text(
          location,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isTop ? FontWeight.w400 : FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}