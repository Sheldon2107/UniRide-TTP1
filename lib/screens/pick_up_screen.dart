import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'constants.dart';
import 'arrived_screen.dart';

class PickUpScreen extends StatelessWidget {
  final LatLng startLocation;
  final LatLng endLocation;
  final String vehicleName;
  final double walletBalance;

  const PickUpScreen({
    super.key,
    required this.startLocation,
    required this.endLocation,
    required this.vehicleName,
    required this.walletBalance,
  });

  void _startTrip(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ArrivedScreen(
          startLocation: startLocation,
          endLocation: endLocation,
          vehicleName: vehicleName,
          walletBalance: walletBalance,
        ),
      ),
    );
  }
=======
import 'arrived_screen.dart';

class PickUpScreen extends StatelessWidget {
  const PickUpScreen({super.key});
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
<<<<<<< HEAD
          // ── Map ────────────────────────────────────────────────────────
          FlutterMap(
            options: MapOptions(
              initialCenter: startLocation,
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.uniride',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [startLocation, endLocation],
                    color: AppColors.brandBlue,
                    strokeWidth: 4,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: startLocation,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.circle,
                      color: AppColors.brandBlue,
                      size: 30,
                    ),
                  ),
                  Marker(
                    point: endLocation,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ── Bottom sheet ──────────────────────────────────────────────
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 12)
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your ride",
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    vehicleName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Balance: RM${walletBalance.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                        backgroundColor: AppColors.brandBlue,
                        disabledBackgroundColor:
                            AppColors.brandBlue.withOpacity(0.4),
=======
                        backgroundColor: const Color(0xFF004687), // Uni-RIDE Theme Color
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
<<<<<<< HEAD
                      onPressed: () => _startTrip(context),
                      child: const Text(
                        "Start Trip",
=======
                      onPressed: () {
                        // Navigates to the Arrived Screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ArrivedScreen()),
                        );
                      },
                      child: const Text(
                        "Confirm pick-up",
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
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