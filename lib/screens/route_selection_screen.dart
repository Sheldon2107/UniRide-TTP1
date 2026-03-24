import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';
import 'vehicle_booking_screen.dart';

class RouteSelectionScreen extends StatefulWidget {
  const RouteSelectionScreen({super.key});

  @override
  State<RouteSelectionScreen> createState() => _RouteSelectionScreenState();
}

class _RouteSelectionScreenState extends State<RouteSelectionScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  LatLng? _pickupLocation;
  LatLng? _destinationLocation;
  bool _isSearchingPickup = false;
  bool _isSearchingDestination = false;

  static const LatLng _defaultCenter = LatLng(4.3890, 100.9659);
  static const String _viewbox = "100.90,4.35,101.05,4.43";

  @override
  void dispose() {
    _pickupController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  double? _getDistanceKm() {
    if (_pickupLocation == null || _destinationLocation == null) return null;
    return Distance().as(
      LengthUnit.Kilometer,
      _pickupLocation!,
      _destinationLocation!,
    );
  }

  String get _distanceLabel {
    final d = _getDistanceKm();
    return d != null ? "${d.toStringAsFixed(1)} km" : "-- km";
  }

  String get _estimatedTimeLabel {
    final d = _getDistanceKm();
    if (d == null) return "-- min";
    return "${((d / 40.0) * 60).toStringAsFixed(0)} min";
  }

  bool get _bothSet =>
      _pickupLocation != null && _destinationLocation != null;

  Future<LatLng?> _geocode(String query) async {
    final uri = Uri.parse(
      "https://nominatim.openstreetmap.org/search"
      "?q=${Uri.encodeComponent(query)}"
      "&format=json"
      "&limit=5"
      "&countrycodes=my"
      "&viewbox=$_viewbox"
      "&bounded=1",
    );

    try {
      final response = await http.get(uri, headers: {
        "User-Agent": "com.example.uniride",
      });

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return LatLng(
            double.parse(data[0]['lat']),
            double.parse(data[0]['lon']),
          );
        }
      }
    } catch (_) {}
    return null;
  }

  Future<void> _searchPickup() async {
    final query = _pickupController.text.trim();
    if (query.isEmpty) return;

    setState(() => _isSearchingPickup = true);
    final result = await _geocode(query);
    setState(() {
      _isSearchingPickup = false;
      if (result != null) {
        _pickupLocation = result;
        _mapController.move(result, 15);
      } else {
        _showNotFound();
      }
    });
  }

  Future<void> _searchDestination() async {
    final query = _destinationController.text.trim();
    if (query.isEmpty) return;

    setState(() => _isSearchingDestination = true);
    final result = await _geocode(query);
    setState(() {
      _isSearchingDestination = false;
      if (result != null) {
        _destinationLocation = result;
        if (_pickupLocation != null) {
          final midLat =
              (_pickupLocation!.latitude + result.latitude) / 2;
          final midLng =
              (_pickupLocation!.longitude + result.longitude) / 2;
          _mapController.move(LatLng(midLat, midLng), 14);
        } else {
          _mapController.move(result, 15);
        }
      } else {
        _showNotFound();
      }
    });
  }

  void _showNotFound() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Location not found in Seri Iskandar area."),
      ),
    );
  }

  void _onMapTap(TapPosition tapPosition, LatLng point) {
    setState(() {
      if (_pickupLocation == null) {
        _pickupLocation = point;
        _pickupController.text =
            "${point.latitude.toStringAsFixed(5)}, "
            "${point.longitude.toStringAsFixed(5)}";
      } else if (_destinationLocation == null) {
        _destinationLocation = point;
        _destinationController.text =
            "${point.latitude.toStringAsFixed(5)}, "
            "${point.longitude.toStringAsFixed(5)}";
      }
    });
  }

  void _reset() {
    setState(() {
      _pickupLocation = null;
      _destinationLocation = null;
      _pickupController.clear();
      _destinationController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // ── Map ────────────────────────────────────────────────────────
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _defaultCenter,
              initialZoom: 15,
              onTap: _onMapTap,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.uniride',
              ),
              if (_bothSet)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: [_pickupLocation!, _destinationLocation!],
                      color: AppColors.brandBlue,
                      strokeWidth: 4,
                    ),
                  ],
                ),
              MarkerLayer(
                markers: [
                  if (_pickupLocation != null)
                    Marker(
                      point: _pickupLocation!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.circle,
                        color: AppColors.brandBlue,
                        size: 30,
                      ),
                    ),
                  if (_destinationLocation != null)
                    Marker(
                      point: _destinationLocation!,
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

          // ── Top search card ─────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 10),
                      ],
                    ),
                    child: Column(
                      children: [
                        // ── Pickup field ──────────────────────────────────
                        Row(
                          children: [
                            const Icon(Icons.circle,
                                color: AppColors.brandBlue, size: 12),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _pickupController,
                                decoration: const InputDecoration(
                                  hintText: "Pickup location",
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onSubmitted: (_) => _searchPickup(),
                              ),
                            ),
                            if (_isSearchingPickup)
                              const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.brandBlue,
                                ),
                              )
                            else
                              GestureDetector(
                                onTap: _searchPickup,
                                child: const Icon(Icons.search,
                                    color: Colors.grey, size: 20),
                              ),
                          ],
                        ),

                        const Divider(height: 16),

                        // ── Destination field ─────────────────────────────
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                color: Colors.red, size: 16),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _destinationController,
                                decoration: const InputDecoration(
                                  hintText: "Where do you want to go?",
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onSubmitted: (_) => _searchDestination(),
                              ),
                            ),
                            if (_isSearchingDestination)
                              const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.brandBlue,
                                ),
                              )
                            else
                              GestureDetector(
                                onTap: _searchDestination,
                                child: const Icon(Icons.search,
                                    color: Colors.grey, size: 20),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ── Distance / time chip ────────────────────────────────
                  if (_bothSet) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 8),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Distance: $_distanceLabel",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                "Estimated time: $_estimatedTimeLabel",
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const Icon(Icons.directions_car,
                              color: Colors.green),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // ── Bottom buttons ──────────────────────────────────────────────
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    if (_pickupLocation != null ||
                        _destinationLocation != null) ...[
                      IconButton.filled(
                        onPressed: _reset,
                        icon: const Icon(Icons.refresh),
                        tooltip: "Reset",
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.background,
                          foregroundColor: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.brandBlue,
                            disabledBackgroundColor:
                                AppColors.brandBlue.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _bothSet
                              ? () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => VehicleBookingScreen(
                                        startLocation: _pickupLocation!,
                                        endLocation: _destinationLocation!,
                                        walletBalance: 50.0,
                                      ),
                                    ),
                                  )
                              : null,
                          child: const Text(
                            "Done",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}