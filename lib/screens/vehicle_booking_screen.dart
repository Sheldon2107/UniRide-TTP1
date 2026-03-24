import 'package:flutter/material.dart';
<<<<<<< HEAD
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
  bool _addPaymentMethod = false;

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
    );
  }

  String _formatCoord(LatLng point) =>
      "${point.latitude.toStringAsFixed(5)}, "
      "${point.longitude.toStringAsFixed(5)}";
=======
import 'wallet_screen.dart'; // Ensure this file is imported

class VehicleBookingScreen extends StatelessWidget {
  const VehicleBookingScreen({super.key});
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
              initialCenter: LatLng(
                (widget.startLocation.latitude +
                        widget.endLocation.latitude) /
                    2,
                (widget.startLocation.longitude +
                        widget.endLocation.longitude) /
                    2,
              ),
              initialZoom: 14,
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
                    points: [widget.startLocation, widget.endLocation],
                    color: AppColors.brandBlue,
                    strokeWidth: 4,
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
                      size: 30,
                    ),
                  ),
                  Marker(
                    point: widget.endLocation,
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

          // ── Top location bar ──────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 20),
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
                              const Icon(Icons.circle,
                                  color: AppColors.brandBlue, size: 10),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _formatCoord(widget.startLocation),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  color: Colors.red, size: 14),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _formatCoord(widget.endLocation),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                ),
              ),
            ),
          ),

<<<<<<< HEAD
          // ── Bottom sheet ──────────────────────────────────────────────
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 12)
                ],
=======
          // 3. VEHICLE SELECTION SHEET
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5), 
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
<<<<<<< HEAD
                  // ── Vehicle list ────────────────────────────────────
                  ...List.generate(_vehicles.length, (index) {
                    final vehicle = _vehicles[index];
                    final bool isSelected = _selectedIndex == index;
                    final bool canAfford = _balance >= vehicle.price;

                    return GestureDetector(
                      onTap: () =>
                          setState(() => _selectedIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.brandBlue.withOpacity(0.06)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.brandBlue
                                : Colors.grey[200]!,
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              vehicle.image,
                              width: 64,
                              height: 40,
                              fit: BoxFit.contain,
                              errorBuilder: (_, _, _) => const Icon(
                                Icons.directions_car,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vehicle.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    vehicle.subtitle,
                                    style: const TextStyle(
                                      fontSize: 12,
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
                                fontSize: 14,
                                color: canAfford
                                    ? AppColors.textPrimary
                                    : AppColors.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 4),

                  // ── Add payment method checkbox ──────────────────────
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: _addPaymentMethod,
                          activeColor: AppColors.brandBlue,
                          onChanged: (val) => setState(
                              () => _addPaymentMethod = val ?? false),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Add Payment method",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ── Action buttons ───────────────────────────────────
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
<<<<<<< HEAD
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.brandBlue,
                              disabledBackgroundColor:
                                  AppColors.brandBlue.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: _selectedVehicle != null
                                ? _onChooseVehicle
                                : null,
                            child: const Text(
                              "Choose Vehicle",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                            ),
                          ),
                        ),
                      ),
<<<<<<< HEAD
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.brandBlue,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _openWallet,
                          child: const Icon(
                            Icons.account_balance_wallet,
                            color: Colors.white,
                          ),
                        ),
=======
                      const SizedBox(width: 12),
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.more_time, color: Colors.black54),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
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
<<<<<<< HEAD
}

// ── Typed vehicle model ───────────────────────────────────────────────────────
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
=======

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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
}