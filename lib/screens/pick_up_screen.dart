import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandBlue,
                        disabledBackgroundColor:
                            AppColors.brandBlue.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => _startTrip(context),
                      child: const Text(
                        "Start Trip",
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