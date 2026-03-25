import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'constants.dart';
import 'active_orders_screen.dart';
import 'account_profile_screen.dart';

class CourierHomeDashboard extends StatefulWidget {
  final String firstName;
  final String lastName;

  const CourierHomeDashboard({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  State<CourierHomeDashboard> createState() => _CourierHomeDashboardState();
}

class _CourierHomeDashboardState extends State<CourierHomeDashboard> {
  static const LatLng _courierLocation = LatLng(4.388965, 100.965852);

  bool _isOnline = false;
  int _currentIndex = 0;
  double _todayEarnings = 0.0;
  int _todayDeliveries = 0;

  // Mock incoming delivery request
  static const _mockDelivery = _DeliveryRequest(
    senderName: "Ahmad Fariz",
    pickup: "V4 Cafe, Seri Iskandar",
    dropoff: "Parcel Hub, UTP",
    distanceKm: 2.4,
    fareRM: 5.00,
  );

  void _toggleOnline() {
    setState(() => _isOnline = !_isOnline);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isOnline
            ? "You are now online. Waiting for delivery requests..."
            : "You are now offline."),
        backgroundColor: _isOnline ? Colors.green : Colors.grey,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ActiveOrdersScreen()),
      ).then((_) => setState(() => _currentIndex = 0));
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AccountProfileScreen()),
      ).then((_) => setState(() => _currentIndex = 0));
    }
  }

  void _onDeliveryRequestTap() {
    if (!_isOnline) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Go online first to accept delivery requests."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Simulate accepting — increment stats
    setState(() {
      _todayEarnings += _mockDelivery.fareRM;
      _todayDeliveries += 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Delivery accepted! Head to pickup location."),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.textPrimary,
        unselectedItemColor: AppColors.textSecondary,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Account"),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, ${widget.firstName}!",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Text(
                          "Courier Dashboard",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.cyan,
                      radius: 22,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // ── Online / Offline toggle ───────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: _toggleOnline,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: _isOnline ? Colors.green : Colors.grey[200],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isOnline
                              ? Icons.moped_rounded
                              : Icons.moped_outlined,
                          color: _isOnline ? Colors.white : Colors.grey[600],
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _isOnline ? "You are Online" : "Go Online",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:
                                _isOnline ? Colors.white : Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Stats row ─────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        label: "Today's Earnings",
                        value:
                            "RM ${_todayEarnings.toStringAsFixed(2)}",
                        icon: Icons.account_balance_wallet_outlined,
                        color: AppColors.brandBlue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        label: "Deliveries Today",
                        value: "$_todayDeliveries",
                        icon: Icons.local_shipping_outlined,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Map ───────────────────────────────────────────────────
              Container(
                height: 200,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FlutterMap(
                    options: const MapOptions(
                      initialCenter: _courierLocation,
                      initialZoom: 14,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: 'com.example.uniride',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _courierLocation,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.moped_rounded,
                              color: AppColors.brandBlue,
                              size: 36,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Incoming delivery request card ────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isOnline
                          ? "Incoming Delivery Request"
                          : "Go online to see requests",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: _onDeliveryRequestTap,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: _isOnline ? 1.0 : 0.4,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: _isOnline
                                  ? AppColors.brandBlue
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Sender + fare
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.cyanAccent,
                                        child: Icon(Icons.person,
                                            size: 18,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        _mockDelivery.senderName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "RM ${_mockDelivery.fareRM.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: AppColors.brandBlue,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),
                              const Divider(height: 1),
                              const SizedBox(height: 12),

                              // Pickup
                              Row(
                                children: [
                                  const Icon(Icons.circle,
                                      color: AppColors.brandBlue, size: 10),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      _mockDelivery.pickup,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: AppColors.textPrimary),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              // Dropoff
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.red, size: 14),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      _mockDelivery.dropoff,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: AppColors.textPrimary),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // Distance + accept button row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.straight,
                                          size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${_mockDelivery.distanceKm} km away",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  if (_isOnline)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 7),
                                      decoration: BoxDecoration(
                                        color: AppColors.brandBlue,
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        "Accept",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Stat card ─────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(label,
              style:
                  TextStyle(fontSize: 12, color: Colors.grey[500])),
        ],
      ),
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────────
class _DeliveryRequest {
  final String senderName;
  final String pickup;
  final String dropoff;
  final double distanceKm;
  final double fareRM;

  const _DeliveryRequest({
    required this.senderName,
    required this.pickup,
    required this.dropoff,
    required this.distanceKm,
    required this.fareRM,
  });
}