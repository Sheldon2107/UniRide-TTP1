import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'constants.dart';
import 'create_shipment_screen.dart';
import 'supporting_courier_document.dart';
=======
// Added the correct import for the Create Shipment screen
import 'create_shipment_screen.dart'; 
import 'supporting_courier_document.dart'; 
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2

class CourierServiceSelection extends StatelessWidget {
  const CourierServiceSelection({super.key});

<<<<<<< HEAD
  void _goToSendPackage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreateShipmentScreen()),
    );
  }

  void _goToBecomeCourier(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SupportingCourierDocumentScreen()),
    );
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
      ),
=======
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
<<<<<<< HEAD
              const SizedBox(height: 20),

              // ── Header ──────────────────────────────────────────────
=======
              const SizedBox(height: 60),
              // Main Greeting Header
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
              const Text(
                "Hello,\nSheldon",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
<<<<<<< HEAD
                  color: AppColors.textPrimary,
=======
                  color: Colors.black,
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                ),
              ),
              const SizedBox(height: 80),

<<<<<<< HEAD
              // ── Subtitle ────────────────────────────────────────────
              const Center(
                child: Text(
                  "What kind of service do you want?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
=======
              // Subtitle Instruction
              const Center(
                child: Text(
                  "What kind of service you want to do",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                  ),
                ),
              ),
              const SizedBox(height: 40),

<<<<<<< HEAD
              // ── Service options ─────────────────────────────────────
              _ServiceButton(
                label: "Send a Package",
                onPressed: () => _goToSendPackage(context),
              ),
              const SizedBox(height: 20),
              _ServiceButton(
                label: "Become a Courier",
                onPressed: () => _goToBecomeCourier(context),
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
              ),
            ],
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
}

// ── Private widget ────────────────────────────────────────────────────────────
class _ServiceButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _ServiceButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
=======

  // Reusable button widget matching the design
  Widget _buildServiceButton(BuildContext context, {required String label, required VoidCallback onPressed}) {
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
<<<<<<< HEAD
          backgroundColor: AppColors.brandBlue,
=======
          backgroundColor: const Color(0xFF004687), // Brand Blue
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
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