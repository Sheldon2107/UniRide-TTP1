import 'package:flutter/material.dart';
import 'supporting_docs_screen.dart'; // Ensure you have created this file

class VehicleInfoScreen extends StatelessWidget {
  const VehicleInfoScreen({super.key});

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
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Vehicle Image Upload Placeholder
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 40, color: Colors.black),
                  SizedBox(height: 8),
                  Text("upload vehicle image", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Category Dropdown
            const Text("Category", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildDropdownField("Select one option"),
            const SizedBox(height: 20),

            // Model Name
            const Text("Model name", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildInputField("Enter your vehicles model name"),
            const SizedBox(height: 20),

            // Number Plate
            const Text("Number plate", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildInputField("Enter your vehicles number plate"),

            const SizedBox(height: 40),

            // Next Button linked to Supporting Documents
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
                    // Navigates to Supporting Documents Screen (Verification 3/3)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SupportingDocsScreen()),
                    );
                  },
                  child: const Text("Next", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          isExpanded: true,
          items: const [
            DropdownMenuItem(value: "Sedan", child: Text("Sedan")),
            DropdownMenuItem(value: "SUV", child: Text("SUV")),
            DropdownMenuItem(value: "Hatchback", child: Text("Hatchback")),
          ],
          onChanged: (value) {},
        ),
      ),
    );
  }

  Widget _buildInputField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
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