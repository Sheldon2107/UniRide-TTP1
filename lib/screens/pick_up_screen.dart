import 'package:flutter/material.dart';
import 'arrived_screen.dart';

class PickUpScreen extends StatelessWidget {
  const PickUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. DARK MODE MAP BACKGROUND
          // This represents the map view of UTP
          Container(
            color: const Color(0xFF1A1C1E), 
            child: const Center(
              child: Text(
                "Map View (UTP Area)", 
                style: TextStyle(color: Colors.white54)
              ),
            ),
          ),

          // 2. TOP NAVIGATION (Back Button)
          // Consistent with your previous screen designs
          Positioned(
            top: 50,
            left: 20,
            child: Material(
              elevation: 4,
              shadowColor: Colors.black54,
              shape: const CircleBorder(),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),

          // 3. PICK-UP SELECTION CONTAINER
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title text
                  const Text(
                    "Choose your pick-up location",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Location Display Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "V4 CAFE", // Location as per your design
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Search Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF5F5F5),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        onPressed: () {
                          // Handle manual search logic
                        },
                        child: const Text(
                          "Search",
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // CONFIRM PICK-UP BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004687), // Uni-RIDE Theme Color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Navigates to the Arrived Screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ArrivedScreen()),
                        );
                      },
                      child: const Text(
                        "Confirm pick-up",
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
          ),
        ],
      ),
    );
  }
}