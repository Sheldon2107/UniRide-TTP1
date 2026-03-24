import 'package:flutter/material.dart';
import 'constants.dart';
import 'create_shipment_screen.dart';
import 'supporting_courier_document.dart';

class CourierServiceSelection extends StatelessWidget {
  const CourierServiceSelection({super.key});

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // ── Header ──────────────────────────────────────────────
              const Text(
                "Hello,\nSheldon",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 80),

              // ── Subtitle ────────────────────────────────────────────
              const Center(
                child: Text(
                  "What kind of service do you want?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // ── Service options ─────────────────────────────────────
              _ServiceButton(
                label: "Send a Package",
                onPressed: () => _goToSendPackage(context),
              ),
              const SizedBox(height: 20),
              _ServiceButton(
                label: "Become a Courier",
                onPressed: () => _goToBecomeCourier(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Private widget ────────────────────────────────────────────────────────────
class _ServiceButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _ServiceButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandBlue,
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