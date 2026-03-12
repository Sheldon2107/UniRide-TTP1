import 'package:flutter/material.dart';
import 'vehicle_booking_screen.dart';

class RouteSelectionScreen extends StatelessWidget {
  const RouteSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Placeholder for Google Map
          Container(color: Colors.grey[300], child: const Center(child: Text("Map View"))),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildAddressInputCard(),
                  const Spacer(),
                  _buildDoneButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressInputCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        children: [
          _inputField("Capital Hill Station", Icons.circle, Colors.grey),
          const Divider(indent: 30),
          _inputField("Wooden Boats", Icons.location_on, Colors.black),
        ],
      ),
    );
  }

  Widget _inputField(String hint, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 15),
        Expanded(child: TextField(decoration: InputDecoration(hintText: hint, border: InputBorder.none))),
      ],
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF004687),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VehicleBookingScreen())),
        child: const Text("Done", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}