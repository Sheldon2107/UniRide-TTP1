import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'trip_complete_screen.dart';

class DriverActiveTripScreen extends StatefulWidget {
  final String passengerName;
  final String pickup;
  final String destination;
  final double fareRM;
  final LatLng pickupLocation;
  final LatLng destinationLocation;
  final String driverName;
  final String vehicleModel;
  final String numberPlate;
  final void Function(double earned) onTripComplete;

  const DriverActiveTripScreen({
    super.key,
    required this.passengerName,
    required this.pickup,
    required this.destination,
    required this.fareRM,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.driverName,
    required this.vehicleModel,
    required this.numberPlate,
    required this.onTripComplete,
  });

  @override
  State<DriverActiveTripScreen> createState() =>
      _DriverActiveTripScreenState();
}

class _DriverActiveTripScreenState extends State<DriverActiveTripScreen> {
  static const Color _brandBlue = Color(0xFF004687);

  // Two phases: heading to pickup, then heading to destination
  bool _pickedUpPassenger = false;

  String get _statusLabel => _pickedUpPassenger
      ? "Heading to destination"
      : "Heading to pickup";

  String get _nextActionLabel =>
      _pickedUpPassenger ? "Complete Trip" : "Picked Up Passenger";

  LatLng get _currentTarget => _pickedUpPassenger
      ? widget.destinationLocation
      : widget.pickupLocation;

  String get _currentTargetLabel =>
      _pickedUpPassenger ? widget.destination : widget.pickup;

  void _onActionTap() {
    if (!_pickedUpPassenger) {
      setState(() => _pickedUpPassenger = true);
    } else {
      widget.onTripComplete(widget.fareRM);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TripCompleteScreen(
            passengerName: widget.passengerName,
            pickup: widget.pickup,
            destination: widget.destination,
            fareRM: widget.fareRM,
            driverName: widget.driverName,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Map ────────────────────────────────────────────────────
          FlutterMap(
            options: MapOptions(
              initialCenter: _currentTarget,
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
                    child: Icon(
                      Icons.circle,
                      color: _pickedUpPassenger
                          ? Colors.grey
                          : _brandBlue,
                      size: 30,
                    ),
                  ),
                  Marker(
                    point: widget.destinationLocation,
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

          // ── Status pill ─────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: _pickedUpPassenger ? Colors.green : _brandBlue,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 8)
                    ],
                  ),
                  child: Text(
                    _statusLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Bottom sheet ──────────────────────────────────────────────
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Passenger row
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.cyanAccent,
                        child: Icon(Icons.person,
                            color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.passengerName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        "RM ${widget.fareRM.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: _brandBlue,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),
                  const Divider(),
                  const SizedBox(height: 10),

                  // Current target label
                  const Text(
                    "Next stop",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        _pickedUpPassenger
                            ? Icons.location_on
                            : Icons.circle,
                        color: _pickedUpPassenger
                            ? Colors.red
                            : _brandBlue,
                        size: _pickedUpPassenger ? 16 : 12,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _currentTargetLabel,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Action button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _pickedUpPassenger
                            ? Colors.green
                            : _brandBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _onActionTap,
                      child: Text(
                        _nextActionLabel,
                        style: const TextStyle(
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