import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'constants.dart';
import 'order_completed_screen.dart';

class ShipmentTrackingScreen extends StatefulWidget {
  final String senderName;
  final String senderPhone;
  final String pickupAddress;
  final String recipientName;
  final String recipientPhone;
  final String dropoffAddress;
  final String courierName;
  final String courierPrice;

  const ShipmentTrackingScreen({
    super.key,
    required this.senderName,
    required this.senderPhone,
    required this.pickupAddress,
    required this.recipientName,
    required this.recipientPhone,
    required this.dropoffAddress,
    required this.courierName,
    required this.courierPrice,
  });

  @override
  State<ShipmentTrackingScreen> createState() => _ShipmentTrackingScreenState();
}

class _ShipmentTrackingScreenState extends State<ShipmentTrackingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _slideController;
  late final Animation<double> _slideAnimation;

  // Hardcoded Ipoh coords — replace with real geocoded values
  final LatLng _pickupLatLng  = const LatLng(4.5975, 101.0901);
  final LatLng _dropoffLatLng = const LatLng(4.6140, 101.1050);

  final List<_TrackingStep> _steps = const [
    _TrackingStep(title: "Order Created",    time: "9:00 AM",  isDone: true,  isActive: false),
    _TrackingStep(title: "Courier Assigned", time: "9:05 AM",  isDone: true,  isActive: false),
    _TrackingStep(title: "Picked Up",        time: "9:15 AM",  isDone: true,  isActive: false),
    _TrackingStep(title: "Out for Delivery", time: "10:00 AM", isDone: true,  isActive: true),
    _TrackingStep(title: "Delivered",        time: "",         isDone: false, isActive: false),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnimation = CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    );
    _slideController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _goToOrderCompleted(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderCompletedScreen(
          courierName: widget.courierName,
          courierPrice: widget.courierPrice,
          pickupAddress: widget.pickupAddress,
          dropoffAddress: widget.dropoffAddress,
          recipientName: widget.recipientName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Map header (replaces AppBar) ──────────────────────────────────
          _buildMapHeader(context),

          // ── Scrollable body ───────────────────────────────────────────────
          Expanded(
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.08),
                end: Offset.zero,
              ).animate(_slideAnimation),
              child: FadeTransition(
                opacity: _slideAnimation,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderText(),
                      const SizedBox(height: 20),
                      _buildCourierCard(),
                      const SizedBox(height: 20),
                      _buildTimeline(),
                      const SizedBox(height: 20),
                      _buildRouteCard(),
                      const SizedBox(height: 24),
                      _buildButtons(context),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Map header ──────────────────────────────────────────────────────────────
  Widget _buildMapHeader(BuildContext context) {
    final midLat = (_pickupLatLng.latitude  + _dropoffLatLng.latitude)  / 2;
    final midLng = (_pickupLatLng.longitude + _dropoffLatLng.longitude) / 2;

    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(midLat, midLng),
              initialZoom: 13.5,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.flutter_application_1',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [_pickupLatLng, _dropoffLatLng],
                    strokeWidth: 4,
                    color: AppColors.brandBlue,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _pickupLatLng,
                    width: 36,
                    height: 36,
                    child: _MapPin(color: Colors.green, icon: Icons.trip_origin),
                  ),
                  Marker(
                    point: _dropoffLatLng,
                    width: 36,
                    height: 36,
                    child: _MapPin(color: Colors.red, icon: Icons.location_on),
                  ),
                ],
              ),
            ],
          ),

          // Top gradient for back button visibility
          Positioned(
            top: 0, left: 0, right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.35),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 12,
            child: SafeArea(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textPrimary,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),

          // Live badge
          Positioned(
            top: MediaQuery.of(context).padding.top + 14,
            right: 16,
            child: SafeArea(
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (_, __) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.lerp(
                            Colors.green,
                            Colors.green.withOpacity(0.4),
                            _pulseController.value,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "LIVE",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Header text ─────────────────────────────────────────────────────────────
  Widget _buildHeaderText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Shipment Tracking",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          "Delivering to ${widget.recipientName}",
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  // ── Courier card ────────────────────────────────────────────────────────────
  Widget _buildCourierCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.brandBlue,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandBlue.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 14),

          // Name + label
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.courierName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  "Your courier · En route",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Price chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.courierPrice,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Chat icon
          GestureDetector(
            onTap: () {}, // TODO: open chat
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Timeline ────────────────────────────────────────────────────────────────
  Widget _buildTimeline() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: List.generate(_steps.length, (i) {
          final step = _steps[i];
          final isLast = i == _steps.length - 1;
          return _buildTimelineRow(step, isLast);
        }),
      ),
    );
  }

  Widget _buildTimelineRow(_TrackingStep step, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon + line
          SizedBox(
            width: 28,
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (_, __) {
                    if (step.isActive) {
                      return Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.brandBlue.withOpacity(
                            0.2 + 0.3 * _pulseController.value,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.brandBlue,
                            ),
                          ),
                        ),
                      );
                    }
                    return Icon(
                      step.isDone
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_unchecked,
                      size: 20,
                      color: step.isDone ? Colors.green : Colors.grey[300],
                    );
                  },
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: step.isDone
                            ? Colors.green.withOpacity(0.35)
                            : Colors.grey[200],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Label + time
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 1,
                bottom: isLast ? 0 : 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    step.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: step.isActive || step.isDone
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: step.isActive
                          ? AppColors.brandBlue
                          : step.isDone
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                    ),
                  ),
                  if (step.time.isNotEmpty)
                    Text(
                      step.time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
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

  // ── Route card ──────────────────────────────────────────────────────────────
  Widget _buildRouteCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildRouteRow(
            dot: Colors.green,
            label: "From",
            value: widget.pickupAddress,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Column(
              children: List.generate(
                3,
                (_) => Container(
                  width: 2,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
          _buildRouteRow(
            dot: Colors.red,
            label: "To",
            value: widget.dropoffAddress,
          ),
        ],
      ),
    );
  }

  Widget _buildRouteRow({
    required Color dot,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: dot.withOpacity(0.15),
            border: Border.all(color: dot, width: 2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Buttons ─────────────────────────────────────────────────────────────────
  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        // Order Completed (primary)
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
            onPressed: () => _goToOrderCompleted(context),
            icon: const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
            label: const Text(
              "Order Completed",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Chat (outlined)
        SizedBox(
          width: double.infinity,
          height: 54,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.brandBlue.withOpacity(0.5)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              // TODO: open chat
            },
            icon: const Icon(Icons.chat_bubble_outline, color: AppColors.brandBlue, size: 18),
            label: const Text(
              "Chat Courier",
              style: TextStyle(
                color: AppColors.brandBlue,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Map pin ───────────────────────────────────────────────────────────────────
class _MapPin extends StatelessWidget {
  final Color color;
  final IconData icon;

  const _MapPin({required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.4), blurRadius: 6, spreadRadius: 1),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}

// ── Step model ────────────────────────────────────────────────────────────────
class _TrackingStep {
  final String title;
  final String time;
  final bool isDone;
  final bool isActive;

  const _TrackingStep({
    required this.title,
    required this.time,
    required this.isDone,
    required this.isActive,
  });
}