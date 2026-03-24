import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/services.dart';
import 'constants.dart';
import 'courier_selection_screen.dart';

class CourierRecipientInfo extends StatefulWidget {
  final String senderName;
  final String senderPhone;
  final String pickupAddress;

  const CourierRecipientInfo({
    super.key,
    required this.senderName,
    required this.senderPhone,
    required this.pickupAddress,
  });
=======
import 'courier_selection_screen.dart'; // Import the next screen in the flow

class CourierRecipientInfo extends StatefulWidget {
  const CourierRecipientInfo({super.key});
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2

  @override
  State<CourierRecipientInfo> createState() => _CourierRecipientInfoState();
}

class _CourierRecipientInfoState extends State<CourierRecipientInfo> {
<<<<<<< HEAD
=======
  // Controllers to capture recipient data
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
  void _goToCourierSelection() {
    if (!_canProceed) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CourierSelectionScreen(
          senderName: widget.senderName,
          senderPhone: widget.senderPhone,
          pickupAddress: widget.pickupAddress,
          recipientName: _nameController.text.trim(),
          recipientPhone: _phoneController.text.trim(),
          dropoffAddress: _addressController.text.trim(),
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
            const SizedBox(height: 20),
<<<<<<< HEAD

            // ── Title ────────────────────────────────────────────────
            const Center(
              child: Text(
                "Recipient Info",
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
                "Where should we deliver the package?",
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // ── Sender summary card ──────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.brandBlue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.brandBlue.withOpacity(0.15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pickup Details",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brandBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryRow(Icons.person_outline, widget.senderName),
                  const SizedBox(height: 4),
                  _buildSummaryRow(Icons.phone_outlined, widget.senderPhone),
                  const SizedBox(height: 4),
                  _buildSummaryRow(Icons.location_on_outlined, widget.pickupAddress),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // ── Recipient name ───────────────────────────────────────
            _buildLabel("Recipient Name"),
            const SizedBox(height: 8),
            _buildTextField(
              hint: "Enter recipient name",
              controller: _nameController,
              inputType: TextInputType.name,
            ),
            const SizedBox(height: 20),

            // ── Recipient phone ──────────────────────────────────────
            _buildLabel("Recipient Phone Number"),
            const SizedBox(height: 8),
            _buildTextField(
              hint: "e.g. 011-1234 5678",
              controller: _phoneController,
              inputType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\-\s]')),
              ],
            ),
            const SizedBox(height: 20),

            // ── Recipient address ────────────────────────────────────
            _buildLabel("Recipient Address"),
            const SizedBox(height: 8),
            _buildTextField(
              hint: "Enter dropoff address",
              controller: _addressController,
              inputType: TextInputType.streetAddress,
              maxLines: 2,
            ),

            const SizedBox(height: 40),

            // ── Confirm button ───────────────────────────────────────
=======
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
            _buildTextField("Enter phone number", _phoneController, keyboardType: TextInputType.phone),
            const SizedBox(height: 25),

            // Recipient Address Field
            const Text("Recipient Address", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildTextField("Enter address", _addressController),
            
            const SizedBox(height: 60),

            // Full-width Confirm Button
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                  backgroundColor: _canProceed
                      ? AppColors.brandBlue
                      : AppColors.brandBlue.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                onPressed: _canProceed ? _goToCourierSelection : null,
                child: const Text(
                  "Confirm & Book Courier",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
=======
                  backgroundColor: const Color(0xFF004687), // Uni-RIDE Blue
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Navigate to the Courier Selection Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CourierSelectionScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Confirm & Book Courier",
                  style: TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 16
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

  Widget _buildSummaryRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.brandBlue),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
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
  Widget _buildTextField(String hint, TextEditingController controller, {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
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