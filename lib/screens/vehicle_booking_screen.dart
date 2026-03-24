import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'constants.dart';
import 'pick_up_screen.dart';
import 'wallet_screen.dart';

class VehicleBookingScreen extends StatefulWidget {
  final LatLng startLocation;
  final LatLng endLocation;
  final double walletBalance;

  const VehicleBookingScreen({
    super.key,
    required this.startLocation,
    required this.endLocation,
    required this.walletBalance,
  });

  @override
  State<VehicleBookingScreen> createState() => _VehicleBookingScreenState();
}

class _VehicleBookingScreenState extends State<VehicleBookingScreen> {
  late double _balance;
  int? _selectedIndex;

  static const List<_VehicleOption> _vehicles = [
    _VehicleOption(
      name: "Perodua Axia",
      subtitle: "on way · 2.1 km away",
      image: "assets/axia.jpeg",
      price: 10.00,
    ),
    _VehicleOption(
      name: "Proton Alza",
      subtitle: "8:00 · 2.1 km away",
      image: "assets/alza.jpeg",
      price: 15.00,
    ),
    _VehicleOption(
      name: "Premium Car",
      subtitle: "8:00 · 8.4 km away",
      image: "assets/premiumcar.jpeg",
      price: 25.00,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _balance = widget.walletBalance;
  }

  _VehicleOption? get _selectedVehicle =>
      _selectedIndex != null ? _vehicles[_selectedIndex!] : null;

  void _onChooseVehicle() {
    final vehicle = _selectedVehicle;
    if (vehicle == null) return;

    if (_balance < vehicle.price) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Insufficient wallet balance")),
      );
      return;
    }

    setState(() => _balance -= vehicle.price);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PickUpScreen(
          startLocation: widget.startLocation,
          endLocation: widget.endLocation,
          vehicleName: vehicle.name,
          walletBalance: _balance,
        ),
      ),
    );
  }

  void _openWallet() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WalletScreen(currentBalance: _balance),
      ),
    ).then((newBalance) {
      // Update balance if user added money in wallet
      if (newBalance != null && newBalance is double) {
        setState(() => _balance = newBalance);
      }
    });
  }

  String _formatCoord(LatLng point) =>
      "${point.latitude.toStringAsFixed(5)}, ${point.longitude.toStringAsFixed(5)}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(
                (widget.startLocation.latitude + widget.endLocation.latitude) / 2,
                (widget.startLocation.longitude + widget.endLocation.longitude) / 2,
              ),
              initialZoom: 14,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.uniride',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [widget.startLocation, widget.endLocation],
                    color: AppColors.brandBlue,
                    strokeWidth: 5,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: widget.startLocation,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.circle,
                      color: AppColors.brandBlue,
                      size: 28,
                    ),
                  ),
                  Marker(
                    point: widget.endLocation,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 36,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Top Location Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.circle, color: AppColors.brandBlue, size: 10),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _formatCoord(widget.startLocation),
                                  style: const TextStyle(fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.red, size: 14),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _formatCoord(widget.endLocation),
                                  style: const TextStyle(fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 15, offset: Offset(0, -4)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Vehicle Options
                  ...List.generate(_vehicles.length, (index) {
                    final vehicle = _vehicles[index];
                    final bool isSelected = _selectedIndex == index;
                    final bool canAfford = _balance >= vehicle.price;

                    return GestureDetector(
                      onTap: () => setState(() => _selectedIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.brandBlue.withOpacity(0.08)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected ? AppColors.brandBlue : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              vehicle.image,
                              width: 72,
                              height: 48,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.directions_car,
                                size: 48,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vehicle.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    vehicle.subtitle,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "RM ${vehicle.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: canAfford ? Colors.black : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 12),

                  // Wallet & Choose Button
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.brandBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _selectedVehicle != null ? _onChooseVehicle : null,
                            child: const Text(
                              "Choose Vehicle",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        height: 52,
                        width: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.brandBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: _openWallet,
                          child: const Icon(
                            Icons.account_balance_wallet,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
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
}

// Vehicle Model
class _VehicleOption {
  final String name;
  final String subtitle;
  final String image;
  final double price;

  const _VehicleOption({
    required this.name,
    required this.subtitle,
    required this.image,
    required this.price,
  });
}