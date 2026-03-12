import 'package:flutter/material.dart';
// - Import the next screen in the flow
import 'active_orders_screen.dart'; 

class SupportingCourierDocumentScreen extends StatelessWidget {
  const SupportingCourierDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          // - Standard back navigation
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
            const SizedBox(height: 20),
            
            // License Verification Section
            const Text("Upload your license photo", style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter license number",
                filled: true,
                fillColor: const Color(0xFFF5F5F5), 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                _buildUploadBox("Front"),
                const SizedBox(width: 15),
                _buildUploadBox("Back"),
              ],
            ),

            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),

            // Billbook/Vehicle Ownership Section
            const Text("Upload your billbook photo", style: TextStyle(color: Colors.black54)),
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

            // Submit Button - Fixed to navigate to Active Orders
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004687), // Uni-RIDE Blue
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // - Navigate to Active Orders after clicking
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ActiveOrdersScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Request for verification",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Helper widget for upload placeholders
  Widget _buildUploadBox(String label) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE), 
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.add, size: 40, color: Colors.black),
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }
}