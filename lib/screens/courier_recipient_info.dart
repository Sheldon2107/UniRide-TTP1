import 'package:flutter/material.dart';
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

  @override
  State<CourierRecipientInfo> createState() => _CourierRecipientInfoState();
}

class _CourierRecipientInfoState extends State<CourierRecipientInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

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

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

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
            SizedBox(
              width: double.infinity,
              height: 55,
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
                onPressed: _canProceed ? _goToCourierSelection : null,
                child: const Text(
                  "Confirm & Book Courier",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

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
      ),
    );
  }
}