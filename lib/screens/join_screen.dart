import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/verify_screen.dart';
// 1. Change this import to your success screen

class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Center(
              child: newMethod(),
            ),
            const Text(
              "Join Uni-Ride",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
            ),
            const Text(
              "The exclusive mobility platform for UTP",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            
            _buildTextField(label: "FULL NAME", hint: "Enter your full name", icon: Icons.person_outline),
            _buildTextField(label: "PASSWORD", hint: "90000000", icon: Icons.lock_outline, isPassword: true),
            _buildTextField(label: "CONFIRM PASSWORD", hint: "90000000", icon: Icons.lock_outline, isPassword: true),
            _buildTextField(label: "UTP EMAIL", hint: "yourname@utp.edu.my", icon: Icons.email_outlined),
            
            const SizedBox(height: 40),
            
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004687),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // 2. Update this to go directly to the Success screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VerifyScreen()),
                  );
                },
                child: const Text("CREATE ACCOUNT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Image newMethod() {
    return Image.asset(
      'assets/logo.png', 
      height: 120, 
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.directions_car, size: 80, color: Color(0xFF004687));
      },
    );
  }

  Widget _buildTextField({required String label, required String hint, required IconData icon, bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
          TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon, size: 20),
              suffixIcon: isPassword ? const Icon(Icons.visibility_off_outlined, size: 20) : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}