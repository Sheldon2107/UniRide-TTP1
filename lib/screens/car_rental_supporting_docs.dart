import 'package:flutter/material.dart';
// Import your final confirmation or dashboard screen
// import 'car_rental_confirmation.dart'; 

class CarRentalSupportingDocs extends StatelessWidget {
  const CarRentalSupportingDocs({super.key});

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
              "Supporting Documents",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),

            // License Photo Section
            const Text("Upload your license photo", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            _buildTextField("Enter license number"),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: _buildUploadBox("Front")),
                const SizedBox(width: 15),
                Expanded(child: _buildUploadBox("Back")),
              ],
            ),
            
            const SizedBox(height: 25),
            const Divider(),
            const SizedBox(height: 25),

            // Billbook Photo Section
            const Text("Upload your billbook photo", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 15),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1.2,
              children: [
                _buildUploadBox("Page 1"),
                _buildUploadBox("Page 2"),
                _buildUploadBox("Page 3"),
                _buildUploadBox("Page 4"),
              ],
            ),
            
            const SizedBox(height: 40),

            // Request Verification Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004687), // Uni-RIDE Blue
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Final submission logic
                },
                child: const Text(
                  "Request for verfication",
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

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildUploadBox(String label) {
    return Column(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.add, size: 30, color: Colors.black),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}