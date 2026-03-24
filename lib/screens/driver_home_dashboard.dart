import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'incoming_ride_screen.dart';
import 'account_profile_screen.dart';

class DriverHomeDashboard extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String vehicleModel;
  final String numberPlate;

  const DriverHomeDashboard({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.vehicleModel,
    required this.numberPlate,
  });

  @override
  State<DriverHomeDashboard> createState() => _DriverHomeDashboardState();
}

class _DriverHomeDashboardState extends State<DriverHomeDashboard> {
  static const Color _brandBlue = Color(0xFF004687);
  static const LatLng _driverLocation = LatLng(4.388965, 100.965852);

  bool _isOnline = false;
  int _currentIndex = 0;
  double _todayEarnings = 0.0;
  int _todayTrips = 0;

  // Simulated incoming ride request
  static const _mockRideRequest = _RideRequest(
    passengerName: "Ahmad Fariz",
    pickup: "V4 Cafe, Seri Iskandar",
    destination: "Chancellor Hall, UTP",
    distanceKm: 2.1,
    fareRM: 10.00,
    pickupLocation: LatLng(4.3902, 100.9641),
    destinationLocation: LatLng(4.3820, 100.9723),
  );

  String get _fullName => "${widget.firstName} ${widget.lastName}".trim();

  void _toggleOnline() {
    setState(() => _isOnline = !_isOnline);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isOnline
            ? "You are now online. Waiting for ride requests..."
            : "You are now offline."),
        backgroundColor: _isOnline ? Colors.green : Colors.grey,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AccountProfileScreen()),
      ).then((_) => setState(() => _currentIndex = 0));
    }
  }

  void _onRideRequestTap() {
    if (!_isOnline) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Go online first to accept ride requests."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => IncomingRideScreen(
          passengerName: _mockRideRequest.passengerName,
          pickup: _mockRideRequest.pickup,
          destination: _mockRideRequest.destination,
          distanceKm: _mockRideRequest.distanceKm,
          fareRM: _mockRideRequest.fareRM,
          pickupLocation: _mockRideRequest.pickupLocation,
          destinationLocation: _mockRideRequest.destinationLocation,
          driverName: _fullName,
          vehicleModel: widget.vehicleModel,
          numberPlate: widget.numberPlate,
          onTripComplete: (double earned) {
            setState(() {
              _todayEarnings += earned;
              _todayTrips += 1;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
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
                          ),
                        ),
                        Text(
                          widget.vehicleModel,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[500],
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
                              ? Icons.wifi_rounded
                              : Icons.wifi_off_rounded,
                          color:
                              _isOnline ? Colors.white : Colors.grey[600],
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _isOnline ? "You are Online" : "Go Online",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _isOnline
                                ? Colors.white
                                : Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Earnings summary ──────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        label: "Today's Earnings",
                        value: "RM ${_todayEarnings.toStringAsFixed(2)}",
                        icon: Icons.account_balance_wallet_outlined,
                        color: _brandBlue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        label: "Trips Today",
                        value: "$_todayTrips",
                        icon: Icons.directions_car_outlined,
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
                      initialCenter: _driverLocation,
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
                            point: _driverLocation,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.directions_car,
                              color: _brandBlue,
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

              // ── Incoming ride request card ─────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isOnline
                          ? "Incoming Ride Request"
                          : "Go online to see requests",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: _onRideRequestTap,
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
                                  ? _brandBlue
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Passenger + fare row
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
                                        _mockRideRequest.passengerName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "RM ${_mockRideRequest.fareRM.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: _brandBlue,
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
                                      color: _brandBlue, size: 10),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      _mockRideRequest.pickup,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              // Destination
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.red, size: 14),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      _mockRideRequest.destination,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // Distance chip
                              Row(
                                children: [
                                  const Icon(Icons.straight,
                                      size: 14, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${_mockRideRequest.distanceKm} km away",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey),
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

// ── Stat card widget ──────────────────────────────────────────────────────────
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
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}

// ── Ride request data model ───────────────────────────────────────────────────
class _RideRequest {
  final String passengerName;
  final String pickup;
  final String destination;
  final double distanceKm;
  final double fareRM;
  final LatLng pickupLocation;
  final LatLng destinationLocation;

  const _RideRequest({
    required this.passengerName,
    required this.pickup,
    required this.destination,
    required this.distanceKm,
    required this.fareRM,
    required this.pickupLocation,
    required this.destinationLocation,
  });
}