import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'constants.dart';
import 'rating_screen.dart';

class ArrivedScreen extends StatelessWidget {
  final LatLng startLocation;
  final LatLng endLocation;
  final String vehicleName;
  final double walletBalance;

  const ArrivedScreen({
    super.key,
    required this.startLocation,
    required this.endLocation,
    required this.vehicleName,
    required this.walletBalance,
  });

  void _goToRating(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => RatingScreen()),
    );
  }
=======
import 'rating_screen.dart'; // Ensure this file is created

class ArrivedScreen extends StatelessWidget {
  const ArrivedScreen({super.key});
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
              initialCenter: endLocation,
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
                    "You have arrived!",
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
                    "Remaining balance: RM${walletBalance.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),
=======
          // 1. DARK MODE MAP BACKGROUND
          Container(
            color: const Color(0xFF1A1C1E),
            child: const Center(
              child: Text(
                "Map: Trip Completed",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),

          // 2. TOP NAVIGATION (Back Button Fix)
          // Fixed 'elevation' error by using Material widget
          Positioned(
            top: 50,
            left: 20,
            child: Material(
              elevation: 4,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              color: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // 3. ARRIVED STATUS SHEET
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pull Handle
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 25),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  // TRIP SUMMARY (V4 CAFE to CHANCELLOR HALL)
                  _buildTripNode(Icons.circle_outlined, "V4 CAFE", isTop: true),

                  // Vertical line connector
                  const Padding(
                    padding: EdgeInsets.only(left: 7),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 30,
                        child: VerticalDivider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  _buildTripNode(Icons.stop, "CHANCELLOR HALL", isTop: false),

                  const SizedBox(height: 40),

                  // FINAL ARRIVED BUTTON
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
                        backgroundColor: const Color(0xFF004687), // Uni-RIDE Blue
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
<<<<<<< HEAD
                      onPressed: () => _goToRating(context),
                      child: const Text(
                        "Arrived! Rate Trip",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
=======
                      onPressed: () {
                        // Navigates to the Rating Screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RatingScreen()),
                        );
                      },
                      child: const Text(
                        "Arrived !",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                        ),
                      ),
                    ),
                  ),
<<<<<<< HEAD
=======
                  const SizedBox(height: 10),
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
=======

  // Helper widget to build the location rows
  Widget _buildTripNode(IconData icon, String location, {required bool isTop}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: isTop ? Colors.grey[700] : Colors.black,
        ),
        const SizedBox(width: 15),
        Text(
          location,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isTop ? FontWeight.w400 : FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
}