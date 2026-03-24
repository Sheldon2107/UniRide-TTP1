import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'constants.dart';
import 'rating_courier_screen.dart';

class OrderCompletedScreen extends StatelessWidget {
  final String courierName;
  final String courierPrice;
  final String pickupAddress;
  final String dropoffAddress;
  final String recipientName;

  const OrderCompletedScreen({
    super.key,
    required this.courierName,
    required this.courierPrice,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.recipientName,
  });

  void _goToRating(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RatingCourierScreen(
          courierName: courierName,
          courierPrice: courierPrice,
        ),
      ),
    );
  }
=======
import 'rating_courier_screen.dart'; // Import the newly created rating screen

class OrderCompletedScreen extends StatelessWidget {
  const OrderCompletedScreen({super.key});
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
=======
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          // Design includes a back button to return to tracking
          icon: const Icon(Icons.arrow_back, color: Colors.black),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
<<<<<<< HEAD
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title ────────────────────────────────────────────────
          const Center(
            child: Text(
              "Order Completed",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              "Delivered to $recipientName",
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // ── Success banner ───────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withOpacity(0.3)),
              ),
              child: const Column(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 48),
                  SizedBox(height: 8),
                  Text(
                    "Package Delivered!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ── Proof of delivery placeholder ─────────────────────────
=======
        children: [
          const Text(
            "Order Completed",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Proof of Delivery Image
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
<<<<<<< HEAD
              child: Container(
                height: 160,
                width: double.infinity,
                color: AppColors.brandBlue.withOpacity(0.06),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo_camera_outlined,
                      size: 40,
                      color: AppColors.brandBlue.withOpacity(0.4),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Proof of delivery",
                      style: TextStyle(
                        color: AppColors.brandBlue.withOpacity(0.5),
                        fontSize: 13,
                      ),
                    ),
                  ],
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                ),
              ),
            ),
          ),
<<<<<<< HEAD
          const SizedBox(height: 20),

          // ── Courier info card ────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.brandBlue.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.brandBlue.withOpacity(0.15),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.brandBlue.withOpacity(0.1),
                    child: const Icon(Icons.person, color: AppColors.brandBlue),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courierName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Text(
                          "Your courier",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    courierPrice,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.brandBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Route summary ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.brandBlue.withOpacity(0.04),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.brandBlue.withOpacity(0.12),
                ),
              ),
              child: Column(
                children: [
                  _buildRouteRow(
                    icon: Icons.trip_origin,
                    iconColor: Colors.green,
                    label: "From",
                    value: pickupAddress,
                  ),
                  const SizedBox(height: 8),
                  _buildRouteRow(
                    icon: Icons.location_on,
                    iconColor: Colors.red,
                    label: "To",
                    value: dropoffAddress,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Delivery timestamp ───────────────────────────────────
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: double.infinity,
<<<<<<< HEAD
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.brandBlue.withOpacity(0.04),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Delivered at  ",
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Text(
                    "17:15",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
=======
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Delivered on 17:15",
                style: TextStyle(color: Colors.black, fontSize: 14),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
              ),
            ),
          ),

          const Spacer(),

<<<<<<< HEAD
          // ── Rate courier button ──────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                onPressed: () => _goToRating(context),
                icon: const Icon(Icons.star_outline, color: Colors.white),
                label: const Text(
                  "Rate Courier",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                  ),
                ),
              ),
            ),
          ),
<<<<<<< HEAD
=======
          const SizedBox(height: 40),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
        ],
      ),
    );
  }
<<<<<<< HEAD

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _buildRouteRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 8),
        Text(
          "$label  ",
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
=======
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
}