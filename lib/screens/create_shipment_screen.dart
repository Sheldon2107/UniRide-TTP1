import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/services.dart';
import 'constants.dart';
import 'courier_recipient_info.dart';
=======
import 'package:flutter_application_1/screens/courier_recipient_info.dart';
// Ensure this file exists
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2

class CreateShipmentScreen extends StatefulWidget {
  const CreateShipmentScreen({super.key});

  @override
  State<CreateShipmentScreen> createState() => _CreateShipmentScreenState();
}

class _CreateShipmentScreenState extends State<CreateShipmentScreen> {
<<<<<<< HEAD
=======
  // Controllers to capture user input
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

<<<<<<< HEAD
  bool get _canProceed =>
      _nameController.text.trim().isNotEmpty &&
      _phoneController.text.trim().isNotEmpty &&
      _addressController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);
    _addressController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() => setState(() {});

=======
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

<<<<<<< HEAD
  void _goToRecipientInfo() {
    if (!_canProceed) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CourierRecipientInfo(
          senderName: _nameController.text.trim(),
          senderPhone: _phoneController.text.trim(),
          pickupAddress: _addressController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
=======
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
<<<<<<< HEAD
            // ── Title ────────────────────────────────────────────────
            const Center(
              child: Text(
                "Create Shipment",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "Fill in your pickup details",
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
=======
            const Center(
              child: Text(
                "Create Shipment",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
              ),
            ),
            const SizedBox(height: 30),

<<<<<<< HEAD
            // ── Package image upload ──────────────────────────────────
            GestureDetector(
              onTap: () {
                // TODO: hook up image_picker here
              },
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: AppColors.brandBlue.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.brandBlue.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 40,
                      color: AppColors.brandBlue.withOpacity(0.6),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Upload package image",
                      style: TextStyle(
                        color: AppColors.brandBlue.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
=======
            // Package Image Upload Area
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
                    "upload package image",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
              ),
            ),
            const SizedBox(height: 30),

<<<<<<< HEAD
            // ── Sender name ──────────────────────────────────────────
            _buildLabel("Name"),
            const SizedBox(height: 8),
            _buildTextField(
              hint: "Enter your name",
              controller: _nameController,
              inputType: TextInputType.name,
            ),
            const SizedBox(height: 20),

            // ── Phone number ─────────────────────────────────────────
            _buildLabel("Phone Number"),
            const SizedBox(height: 8),
            _buildTextField(
              hint: "e.g. 011-1234 5678",
              controller: _phoneController,
              inputType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9\-\s]'))],
            ),
            const SizedBox(height: 20),

            // ── Pickup address ───────────────────────────────────────
            _buildLabel("Pickup Address"),
            const SizedBox(height: 8),
            _buildTextField(
              hint: "Enter pickup address",
              controller: _addressController,
              inputType: TextInputType.streetAddress,
              maxLines: 2,
            ),

            const SizedBox(height: 40),

            // ── Next button ──────────────────────────────────────────
=======
            // Input Fields
            const Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildTextField("Insert Name", _nameController),
            const SizedBox(height: 20),

            const Text("Phone Number", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildTextField("Enter phone number", _phoneController),
            const SizedBox(height: 20),

            const Text("Pick up Address", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildTextField("Enter pickup address", _addressController),
            
            const SizedBox(height: 40),

            // Next Button navigating to Recipient Info
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 120,
<<<<<<< HEAD
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _canProceed
                        ? AppColors.brandBlue
                        : AppColors.brandBlue.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _canProceed ? _goToRecipientInfo : null,
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
=======
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004687), // Uni-RIDE Blue
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // Navigate to the Recipient Info screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CourierRecipientInfo(),
                      ),
                    );
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                  ),
                ),
              ),
            ),
<<<<<<< HEAD
            const SizedBox(height: 30),
=======
            const SizedBox(height: 20),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
    TextInputType inputType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: AppColors.textSecondary.withOpacity(0.6),
          fontSize: 13,
        ),
        filled: true,
        fillColor: AppColors.brandBlue.withOpacity(0.04),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.brandBlue.withOpacity(0.4),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
=======
  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
      ),
    );
  }
}