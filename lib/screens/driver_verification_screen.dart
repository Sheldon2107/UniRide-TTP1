import 'package:flutter/material.dart';
import 'vehicle_info_screen.dart'; // Ensure you have created this file

class DriverVerificationScreen extends StatelessWidget {
  const DriverVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Verification- 1/3",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Profile Image Picker
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(Icons.person, size: 50, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  const Text("Click to Pick", style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            // Firstname and Lastname Row
            Row(
              children: [
                Expanded(child: _buildTextField("Firstname")),
                const SizedBox(width: 15),
                Expanded(child: _buildTextField("Lastname")),
              ],
            ),
            const SizedBox(height: 20),

            // DOB Section
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("DOB", style: TextStyle(color: Colors.grey)),
                  const Text("10-26-2016", style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),

            // Address Field
            _buildTextField("Permanent Address"),
            
            const SizedBox(height: 40),

            // Next Button linked to Vehicle Information
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004687), // Uni-RIDE Blue
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // Navigates to the Vehicle Information screen (Verification 2/3)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VehicleInfoScreen()),
                  );
                },
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }
}