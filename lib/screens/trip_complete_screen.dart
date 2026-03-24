import 'package:flutter/material.dart';

class TripCompleteScreen extends StatefulWidget {
  final String passengerName;
  final String pickup;
  final String destination;
  final double fareRM;
  final String driverName;

  const TripCompleteScreen({
    super.key,
    required this.passengerName,
    required this.pickup,
    required this.destination,
    required this.fareRM,
    required this.driverName,
  });

  @override
  State<TripCompleteScreen> createState() => _TripCompleteScreenState();
}

class _TripCompleteScreenState extends State<TripCompleteScreen> {
  int _rating = 0;
  static const Color _brandBlue = Color(0xFF004687);

  void _onSubmit() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),

              // ── Success icon ────────────────────────────────────────
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 60,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Trip Complete!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "You have arrived at ${widget.destination}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),

              const SizedBox(height: 30),

              // ── Fare card ─────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Fare Earned",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "RM ${widget.fareRM.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: _brandBlue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 12),
                    _TripDetailRow(
                      label: "Passenger",
                      value: widget.passengerName,
                    ),
                    const SizedBox(height: 8),
                    _TripDetailRow(
                      label: "From",
                      value: widget.pickup,
                    ),
                    const SizedBox(height: 8),
                    _TripDetailRow(
                      label: "To",
                      value: widget.destination,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ── Rate passenger ────────────────────────────────────
              const Text(
                "Rate your passenger",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: index < _rating
                          ? _brandBlue
                          : Colors.grey[300],
                      size: 36,
                    ),
                    onPressed: () =>
                        setState(() => _rating = index + 1),
                  );
                }),
              ),

              const Spacer(),

              // ── Done button ───────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _brandBlue,
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _rating > 0 ? _onSubmit : null,
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

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Trip detail row ───────────────────────────────────────────────────────────
class _TripDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _TripDetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
