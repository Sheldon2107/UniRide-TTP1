import 'package:flutter/material.dart';
// Added the correct import for the Create Shipment screen
import 'create_shipment_screen.dart'; 
import 'supporting_courier_document.dart'; 

class CourierServiceSelection extends StatelessWidget {
  const CourierServiceSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              // Main Greeting Header
              const Text(
                "Hello,\nSheldon",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 80),

              // Subtitle Instruction
              const Center(
                child: Text(
                  "What kind of service you want to do",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Option 1: Send a Packages - Fixed to route to CreateShipmentScreen
              _buildServiceButton(
                context,
                label: "Send a Packages",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateShipmentScreen(),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 20),

              // Option 2: Become a Courier
              _buildServiceButton(
                context,
                label: "Become a Courier",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SupportingCourierDocumentScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable button widget matching the design
  Widget _buildServiceButton(BuildContext context, {required String label, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF004687), // Brand Blue
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}