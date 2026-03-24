import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'driver_active_trip_screen.dart';

class IncomingRideScreen extends StatefulWidget {
  final String passengerName;
  final String pickup;
  final String destination;
  final double distanceKm;
  final double fareRM;
  final LatLng pickupLocation;
  final LatLng destinationLocation;
  final String driverName;
  final String vehicleModel;
  final String numberPlate;
  final void Function(double earned) onTripComplete;

  const IncomingRideScreen({
    super.key,
    required this.passengerName,
    required this.pickup,
    required this.destination,
    required this.distanceKm,
    required this.fareRM,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.driverName,
    required this.vehicleModel,
    required this.numberPlate,
    required this.onTripComplete,
  });

  @override
  State<IncomingRideScreen> createState() => _IncomingRideScreenState();
}

class _IncomingRideScreenState extends State<IncomingRideScreen> {
  static const Color _brandBlue = Color(0xFF004687);

  // Auto-decline countdown
  int _countdown = 15;
  bool _responded = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() async {
    while (_countdown > 0 && !_responded && mounted) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted && !_responded) {
        setState(() => _countdown--);
      }
    }
    if (!_responded && mounted) {
      _onDecline();
    }
  }

  void _onAccept() {
    setState(() => _responded = true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DriverActiveTripScreen(
          passengerName: widget.passengerName,
          pickup: widget.pickup,
          destination: widget.destination,
          fareRM: widget.fareRM,
          pickupLocation: widget.pickupLocation,
          destinationLocation: widget.destinationLocation,
          driverName: widget.driverName,
          vehicleModel: widget.vehicleModel,
          numberPlate: widget.numberPlate,
          onTripComplete: widget.onTripComplete,
        ),
      ),
    );
  }

  void _onDecline() {
    setState(() => _responded = true);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── Map ──────────────────────────────────────────────────────
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(
                (widget.pickupLocation.latitude +
                        widget.destinationLocation.latitude) /
                    2,
                (widget.pickupLocation.longitude +
                        widget.destinationLocation.longitude) /
                    2,
              ),
              initialZoom: 13,
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
                    points: [
                      widget.pickupLocation,
                      widget.destinationLocation,
                    ],
                    color: _brandBlue,
                    strokeWidth: 4,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: widget.pickupLocation,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.circle,
                        color: _brandBlue, size: 30),
                  ),
                  Marker(
                    point: widget.destinationLocation,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.location_on,
                        color: Colors.red, size: 40),
                  ),
                ],
              ),
            ],
          ),

          // ── Bottom sheet ─────────────────────────────────────────────
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 36),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(28)),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 12)
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Countdown indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "New Ride Request",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _countdown > 5
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "$_countdown s",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _countdown > 5
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Passenger info
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.cyanAccent,
                        child: Icon(Icons.person,
                            color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.passengerName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const Text(
                              "4.8 ★",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "RM ${widget.fareRM.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _brandBlue,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 12),

                  // Pickup
                  Row(
                    children: [
                      const Icon(Icons.circle,
                          color: _brandBlue, size: 10),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(widget.pickup,
                            style: const TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Destination
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.red, size: 14),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(widget.destination,
                            style: const TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Distance
                  Row(
                    children: [
                      const Icon(Icons.straight,
                          size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.distanceKm} km",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Accept / Decline buttons
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _onDecline,
                            child: const Text(
                              "Decline",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _brandBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _onAccept,
                            child: const Text(
                              "Accept",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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