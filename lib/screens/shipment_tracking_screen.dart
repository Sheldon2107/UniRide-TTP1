import 'package:flutter/material.dart';
import 'order_completed_screen.dart'; // Import the final screen

class ShipmentTrackingScreen extends StatelessWidget {
  const ShipmentTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          // Design includes a back arrow
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const Text(
            "Shipment Tracking",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),

          // Tracking Timeline reflecting the current delivery status
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                _buildTrackingStep("Order Created", "9:00 AM", true, true),
                _buildTrackingStep("Courier Assigned", "9:05 AM", true, true),
                _buildTrackingStep("Picked Up", "9:15 AM", true, true),
                _buildTrackingStep("Out for Delivery", "10:00 AM", true, false),
                _buildTrackingStep("Delivered", "", false, false, isLast: true),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Courier Info Card for the assigned driver
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFE0E0E0), // Light grey background per wireframe
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue[50],
                child: const Icon(Icons.person, color: Color(0xFF004687)),
              ),
              title: const Text("Aniq", style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Text("Rm 5", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),

          const Spacer(),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                _buildActionButton("Chat Courier", () {
                  // Logic to trigger when user wants to chat
                }),
                const SizedBox(height: 12),
                _buildActionButton("Home", () {
                  // In a real app, the "Delivered" status would trigger this.
                  // For testing, clicking Home here will navigate to the final screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderCompletedScreen()),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
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

  // Helper to build the vertical tracking timeline
  Widget _buildTrackingStep(String title, String time, bool isCompleted, bool isActive, {bool isLast = false}) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Icon(
                isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isCompleted ? Colors.green : Colors.grey,
                size: 20,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? Colors.green : Colors.grey[300],
                  ),
                ),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      color: isActive ? Colors.black : Colors.grey,
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF004687), // Brand consistent Blue
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}