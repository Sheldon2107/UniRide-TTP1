import 'package:flutter/material.dart';
import 'home_dashboard.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const Text("Thank You!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text("Choose how you want to use the app", textAlign: TextAlign.center),
            const SizedBox(height: 50),
            _roleButton(context, "Passenger"),
            _roleButton(context, "Driver"),
            _roleButton(context, "Car Rental"),
            _roleButton(context, "Courier Services"),
          ],
        ),
      ),
    );
  }

  Widget _roleButton(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF004687),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeDashboard()));
          },
          child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }
}