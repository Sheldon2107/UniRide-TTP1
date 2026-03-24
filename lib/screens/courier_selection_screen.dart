import 'package:flutter/material.dart';
import 'constants.dart';
import 'shipment_tracking_screen.dart';

class CourierSelectionScreen extends StatefulWidget {
  final String senderName;
  final String senderPhone;
  final String pickupAddress;
  final String recipientName;
  final String recipientPhone;
  final String dropoffAddress;

  const CourierSelectionScreen({
    super.key,
    required this.senderName,
    required this.senderPhone,
    required this.pickupAddress,
    required this.recipientName,
    required this.recipientPhone,
    required this.dropoffAddress,
  });

  @override
  State<CourierSelectionScreen> createState() => _CourierSelectionScreenState();
}

class _CourierSelectionScreenState extends State<CourierSelectionScreen> {
  int _selectedCourierIndex = 0;

  static const List<_CourierOption> _couriers = [
    _CourierOption(name: "Aniq",  details: "16:30 · 3 min away",  price: "RM 5"),
    _CourierOption(name: "Fatma", details: "16:00 · 10 min away", price: "RM 5"),
  ];

  void _goToTracking() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ShipmentTrackingScreen(
          senderName: widget.senderName,
          senderPhone: widget.senderPhone,
          pickupAddress: widget.pickupAddress,
          recipientName: widget.recipientName,
          recipientPhone: widget.recipientPhone,
          dropoffAddress: widget.dropoffAddress,
          courierName: _couriers[_selectedCourierIndex].name,
          courierPrice: _couriers[_selectedCourierIndex].price,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // ── Map area ─────────────────────────────────────────────
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                // Map placeholder
                Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.map, size: 64, color: Colors.grey),
                  ),
                ),

                // Distance tag
                Positioned(
                  top: 60,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "6.2 km",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Route summary pill (pickup → dropoff)
                Positioned(
                  bottom: 12,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.trip_origin,
                          color: Colors.greenAccent,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            widget.pickupAddress,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white54,
                            size: 12,
                          ),
                        ),
                        const Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.dropoffAddress,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom panel ─────────────────────────────────────────
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Available Couriers",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        "${_couriers.length} nearby",
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Courier tiles ───────────────────────────────────
                ...List.generate(_couriers.length, (i) {
                  final c = _couriers[i];
                  final bool isSelected = _selectedCourierIndex == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCourierIndex = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.brandBlue.withOpacity(0.08)
                            : AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.brandBlue.withOpacity(0.4)
                              : Colors.grey.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Avatar
                          CircleAvatar(
                            backgroundColor:
                                AppColors.brandBlue.withOpacity(0.1),
                            child: Icon(
                              Icons.person,
                              color: AppColors.brandBlue,
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Name + details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  c.details,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Price + selected indicator
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                c.price,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: isSelected
                                      ? AppColors.brandBlue
                                      : AppColors.textPrimary,
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle,
                                  color: AppColors.brandBlue,
                                  size: 16,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                const Spacer(),

                // ── Payment method ──────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.credit_card,
                        color: AppColors.textSecondary,
                      ),
                      title: const Text(
                        "Add payment method",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: AppColors.textSecondary,
                      ),
                      onTap: () {
                        // TODO: open payment method picker
                      },
                    ),
                  ),
                ),

                // ── Choose courier button ───────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _goToTracking,
                      child: const Text(
                        "Choose Courier",
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
        ],
      ),
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────────
class _CourierOption {
  final String name;
  final String details;
  final String price;

  const _CourierOption({
    required this.name,
    required this.details,
    required this.price,
  });
}