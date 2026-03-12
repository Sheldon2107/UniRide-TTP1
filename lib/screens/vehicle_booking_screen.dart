import 'package:flutter/material.dart';
import 'wallet_screen.dart'; // Ensure this file is imported

class VehicleBookingScreen extends StatelessWidget {
  const VehicleBookingScreen({super.key});

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
                "Map with Route (UTP)", 
                style: TextStyle(color: Colors.white54)
              ),
            ),
          ),

          // 2. TOP NAVIGATION (Fixed Elevation Error)
          Positioned(
            top: 50,
            left: 20,
            child: Material( // Used Material instead of PhysicalModel for better elevation handling
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

          // 3. VEHICLE SELECTION SHEET
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5), 
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pull Handle
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  // VEHICLE LIST WITH ASSETS
                  _vehicleOption(
                    "Taxi", 
                    "4", 
                    "RM 2.00", 
                    "assets/axia.jpeg", 
                    "16:30 - 3 min away"
                  ),
                  _vehicleOption(
                    "Carpool", 
                    "4", 
                    "RM 1.90", 
                    "assets/alza.jpeg", 
                    "16:00 - 10 min away"
                  ),
                  _vehicleOption(
                    "Premium", 
                    "4", 
                    "RM 2.50", 
                    "assets/premiumcar.jpeg", 
                    "16:00 - 6 min away"
                  ),

                  const Divider(height: 30),

                  // PAYMENT METHOD (Added Navigation to Wallet Section)
                  ListTile(
                    dense: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WalletScreen()),
                      );
                    },
                    leading: const Icon(Icons.credit_card, size: 20),
                    title: const Text("Add Payment method", style: TextStyle(fontSize: 13)),
                    trailing: const Icon(Icons.chevron_right, size: 18),
                  ),

                  const SizedBox(height: 10),

                  // ACTION BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF004687), 
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              // Confirm Booking Logic
                            },
                            child: const Text(
                              "Choose Vehicle",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.more_time, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // HELPER WIDGET FOR VEHICLE ROWS
  Widget _vehicleOption(String name, String seats, String price, String imagePath, String time) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
        width: 80, 
        child: Image.asset(
          imagePath, 
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.directions_car, size: 40),
        ),
      ),
      title: Row(
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          const SizedBox(width: 6),
          const Icon(Icons.person, size: 12, color: Colors.grey),
          Text(seats, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ],
      ),
      subtitle: Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      trailing: Text(
        price,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
      ),
    );
  }
}