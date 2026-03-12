import 'package:flutter/material.dart';
import 'rating_courier_screen.dart'; // Import the newly created rating screen

class OrderCompletedScreen extends StatelessWidget {
  const OrderCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          // Design includes a back button to return to tracking
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const Text(
            "Order Completed",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Proof of Delivery Image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://storage.googleapis.com/flutter-static-artifacts/figma-images/package_proof.png',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, size: 50, color: Colors.grey),
                      SizedBox(height: 8),
                      Text("upload package image", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Courier Details Banner
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFE0E0E0), // Grey background for the courier strip
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue[50],
                // Matches the avatar style from the previous screens
                child: const Icon(Icons.person, color: Color(0xFF004687)),
              ),
              title: const Text("Aniq", style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Text("Rm 5", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 20),

          // Delivery Timestamp
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Delivered on 17:15",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ),

          const Spacer(),

          // Rate Courier Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004687), // Brand Blue
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Navigate to the rating screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RatingCourierScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Rate Courier",
                  style: TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 16
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}