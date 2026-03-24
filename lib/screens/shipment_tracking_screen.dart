import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'constants.dart';
import 'order_completed_screen.dart';

class ShipmentTrackingScreen extends StatelessWidget {
  final String senderName;
  final String senderPhone;
  final String pickupAddress;
  final String recipientName;
  final String recipientPhone;
  final String dropoffAddress;
  final String courierName;
  final String courierPrice;

  const ShipmentTrackingScreen({
    super.key,
    required this.senderName,
    required this.senderPhone,
    required this.pickupAddress,
    required this.recipientName,
    required this.recipientPhone,
    required this.dropoffAddress,
    required this.courierName,
    required this.courierPrice,
  });

  void _goToOrderCompleted(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderCompletedScreen(
          courierName: courierName,
          courierPrice: courierPrice,
          pickupAddress: pickupAddress,
          dropoffAddress: dropoffAddress,
          recipientName: recipientName,
        ),
      ),
    );
  }
=======
import 'order_completed_screen.dart'; // Import the final screen

class ShipmentTrackingScreen extends StatelessWidget {
  const ShipmentTrackingScreen({super.key});
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
          // Design includes a back arrow
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
              "Shipment Tracking",
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
              "Delivering to $recipientName",
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 30),

          // ── Tracking timeline ─────────────────────────────────────
=======
        children: [
          const Text(
            "Shipment Tracking",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),

          // Tracking Timeline reflecting the current delivery status
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
<<<<<<< HEAD
                _buildTrackingStep(
                  title: "Order Created",
                  time: "9:00 AM",
                  isCompleted: true,
                  isActive: false,
                ),
                _buildTrackingStep(
                  title: "Courier Assigned",
                  time: "9:05 AM",
                  isCompleted: true,
                  isActive: false,
                ),
                _buildTrackingStep(
                  title: "Picked Up",
                  time: "9:15 AM",
                  isCompleted: true,
                  isActive: false,
                ),
                _buildTrackingStep(
                  title: "Out for Delivery",
                  time: "10:00 AM",
                  isCompleted: true,
                  isActive: true,
                ),
                _buildTrackingStep(
                  title: "Delivered",
                  time: "",
                  isCompleted: false,
                  isActive: false,
                  isLast: true,
                ),
=======
                _buildTrackingStep("Order Created", "9:00 AM", true, true),
                _buildTrackingStep("Courier Assigned", "9:05 AM", true, true),
                _buildTrackingStep("Picked Up", "9:15 AM", true, true),
                _buildTrackingStep("Out for Delivery", "10:00 AM", true, false),
                _buildTrackingStep("Delivered", "", false, false, isLast: true),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
              ],
            ),
          ),

<<<<<<< HEAD
          const SizedBox(height: 24),

          // ── Route summary ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.brandBlue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.brandBlue.withOpacity(0.15),
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
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            ),
          ),

          const Spacer(),

<<<<<<< HEAD
          // ── Action buttons ───────────────────────────────────────
=======
          // Action Buttons
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
<<<<<<< HEAD
                _buildActionButton(
                  label: "Chat Courier",
                  icon: Icons.chat_bubble_outline,
                  onPressed: () {
                    // TODO: open chat
                  },
                  outlined: true,
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  label: "Order Completed",
                  icon: Icons.check_circle_outline,
                  onPressed: () => _goToOrderCompleted(context),
                ),
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
<<<<<<< HEAD
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _buildTrackingStep({
    required String title,
    required String time,
    required bool isCompleted,
    required bool isActive,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          // Icon + connector line
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
          Column(
            children: [
              Icon(
                isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
<<<<<<< HEAD
                color: isCompleted ? Colors.green : Colors.grey[400],
=======
                color: isCompleted ? Colors.green : Colors.grey,
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                size: 20,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
<<<<<<< HEAD
                    color: isCompleted
                        ? Colors.green.withOpacity(0.4)
                        : Colors.grey[300],
=======
                    color: isCompleted ? Colors.green : Colors.grey[300],
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                  ),
                ),
            ],
          ),
<<<<<<< HEAD
          const SizedBox(width: 16),

          // Title + time
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
=======
          const SizedBox(width: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
<<<<<<< HEAD
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                      fontSize: 14,
                      color: isActive
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                  if (time.isNotEmpty)
                    Text(
                      time,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
=======
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      color: isActive ? Colors.black : Colors.grey,
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
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

  Widget _buildActionButton({
    required String label,
    required VoidCallback onPressed,
    IconData? icon,
    bool outlined = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: outlined
          ? OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.brandBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: onPressed,
              icon: Icon(icon, color: AppColors.brandBlue, size: 18),
              label: Text(
                label,
                style: const TextStyle(
                  color: AppColors.brandBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brandBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              onPressed: onPressed,
              icon: Icon(icon, color: Colors.white, size: 18),
              label: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
    );
  }
}