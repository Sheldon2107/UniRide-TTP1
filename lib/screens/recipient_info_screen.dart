import 'package:flutter/material.dart';

class RecipientInfoScreen extends StatefulWidget {
  const RecipientInfoScreen({super.key});

  @override
  State<RecipientInfoScreen> createState() => _RecipientInfoScreenState();
}

class _RecipientInfoScreenState extends State<RecipientInfoScreen> {
  // Controllers for recipient data
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

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
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Recipient Info",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 40),

            // Recipient Name Field
            const Text("Recipient Name", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildTextField("Insert Name", _nameController),
            const SizedBox(height: 25),

            // Recipient Phone Number Field
            const Text("Recipient Phone Number", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildTextField("", _phoneController, keyboardType: TextInputType.phone),
            const SizedBox(height: 25),

            // Recipient Address Field
            const Text("Recipient Address", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildTextField("", _addressController),
            
            const SizedBox(height: 60),

            // Full-width Confirm Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004687), // Uni-RIDE Blue
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Final booking logic goes here
                },
                child: const Text(
                  "Confirm & Book Courier",
                  style: TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 16
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

  Widget _buildTextField(String hint, TextEditingController controller, {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        filled: true,
        fillColor: const Color(0xFFF5F5F5), // Standard light grey
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }
}