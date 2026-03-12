import 'package:flutter/material.dart';
import 'car_rental_vehicle_info.dart'; // Import the second step

class CarRentalVerification extends StatelessWidget {
  const CarRentalVerification({super.key});

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
            const SizedBox(height: 20),
            
            // Profile Photo Picker
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(Icons.person, size: 50, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text("Click to Pick", style: TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Name Fields Row
            Row(
              children: [
                Expanded(child: _buildInputBox("Firstname")),
                const SizedBox(width: 15),
                Expanded(child: _buildInputBox("Lastname")),
              ],
            ),
            const SizedBox(height: 20),

            // Date of Birth Section
            const Divider(thickness: 1),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("DOB", style: TextStyle(fontSize: 14, color: Colors.black)),
                  Text("10-26-2016", style: TextStyle(fontSize: 14, color: Colors.black)),
                ],
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 20),

            // Address Field
            _buildInputBox("Permanent Address"),
            const SizedBox(height: 40),

            // Navigation Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004687), // Uni-RIDE Blue
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Link to Step 2/3: Vehicle Information
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CarRentalVehicleInfo()),
                  );
                },
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBox(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFF5F5F5), // Light grey input style
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }
}