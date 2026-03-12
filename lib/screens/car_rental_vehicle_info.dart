import 'package:flutter/material.dart';
import 'car_rental_supporting_docs.dart'; // Import the final verification step

class CarRentalVehicleInfo extends StatelessWidget {
  const CarRentalVehicleInfo({super.key});

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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Vehicle Information",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),

            // Vehicle Image Upload Area
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5), // Light grey matching design
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, size: 40, color: Colors.black),
                  const SizedBox(height: 8),
                  const Text(
                    "upload vehicle image",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Category Dropdown
            const Text("Category", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildDropdownField("Select one option"),
            const SizedBox(height: 20),

            // Model Name Input
            const Text("Model name", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildTextField("Enter your vehicles model name"),
            const SizedBox(height: 20),

            // Number Plate Input
            const Text("Number plate", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildTextField("Enter your vehicles number plate"),
            
            const SizedBox(height: 40),

            // Right-aligned Next Button
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 120,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004687), // Uni-RIDE Blue
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // Navigate to Step 3/3: Supporting Documents
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CarRentalSupportingDocs(),
                      ),
                    );
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }

  Widget _buildDropdownField(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
          items: const [
            DropdownMenuItem(value: "Car", child: Text("Car")),
            DropdownMenuItem(value: "SUV", child: Text("SUV")),
            DropdownMenuItem(value: "Van", child: Text("Van")),
          ],
          onChanged: (value) {
            // Logic to handle category selection
          },
        ),
      ),
    );
  }
}