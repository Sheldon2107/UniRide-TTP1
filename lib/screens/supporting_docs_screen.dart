import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'verification_pending_screen.dart';


class SupportingDocsScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String dob;
  final String address;
  final String vehicleCategory;
  final String vehicleModel;
  final String numberPlate;

  const SupportingDocsScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.address,
    required this.vehicleCategory,
    required this.vehicleModel,
    required this.numberPlate,
  });

  @override
  State<SupportingDocsScreen> createState() => _SupportingDocsScreenState();
}

class _SupportingDocsScreenState extends State<SupportingDocsScreen> {
  final TextEditingController _licenseController = TextEditingController();

  // Track which upload boxes have been "uploaded"
  // In a real app these would be XFile? from image_picker
  final Map<String, bool> _uploaded = {
    'license_front': false,
    'license_back': false,
    'billbook_1': false,
    'billbook_2': false,
    'billbook_3': false,
    'billbook_4': false,
  };

  static const Color _brandBlue = Color(0xFF004687);

  @override
  void dispose() {
    _licenseController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _licenseController.text.trim().isNotEmpty &&
      _uploaded['license_front']! &&
      _uploaded['license_back']! &&
      _uploaded['billbook_1']! &&
      _uploaded['billbook_2']! &&
      _uploaded['billbook_3']! &&
      _uploaded['billbook_4']!;

  void _toggleUpload(String key) {
    setState(() => _uploaded[key] = !_uploaded[key]!);
  }

  void _onSubmit() {
  if (!_isFormValid) return;
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => VerificationPendingScreen(
        firstName: widget.firstName,
        lastName: widget.lastName,
        dob: widget.dob,
        address: widget.address,
        vehicleCategory: widget.vehicleCategory,
        vehicleModel: widget.vehicleModel,
        numberPlate: widget.numberPlate,
        licenseNumber: _licenseController.text.trim(),
      ),
    ),
  );
}
=======
import 'account_profile_screen.dart'; // Ensure you have created this file

class SupportingDocsScreen extends StatelessWidget {
  const SupportingDocsScreen({super.key});

>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
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
<<<<<<< HEAD
        title: const Text(
          "Verification - 3/3",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

=======
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            const Text(
              "Supporting Documents",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
<<<<<<< HEAD

            const SizedBox(height: 20),

            // ── License section ───────────────────────────────────────────
            const Text(
              "Upload your license photo",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),

            // License number input
            TextField(
              controller: _licenseController,
              onChanged: (_) => setState(() {}),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.characters,
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

            // License front & back
            Row(
              children: [
                Expanded(
                  child: _UploadBox(
                    label: "Front",
                    isUploaded: _uploaded['license_front']!,
                    onTap: () => _toggleUpload('license_front'),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _UploadBox(
                    label: "Back",
                    isUploaded: _uploaded['license_back']!,
                    onTap: () => _toggleUpload('license_back'),
                  ),
                ),
              ],
            ),

=======
            const SizedBox(height: 20),

            // License Section
            const Text("Upload your license photo", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            _buildNumberInput("Enter license number"),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: _buildUploadBox("Front")),
                const SizedBox(width: 15),
                Expanded(child: _buildUploadBox("Back")),
              ],
            ),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            const SizedBox(height: 25),
            const Divider(thickness: 1),
            const SizedBox(height: 15),

<<<<<<< HEAD
            // ── Billbook section ──────────────────────────────────────────
            const Text(
              "Upload your billbook photo",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 15),

=======
            // Billbook Section
            const Text("Upload your billbook photo", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 15),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1.3,
              children: [
<<<<<<< HEAD
                _UploadBox(
                  label: "Page 1",
                  isUploaded: _uploaded['billbook_1']!,
                  onTap: () => _toggleUpload('billbook_1'),
                ),
                _UploadBox(
                  label: "Page 2",
                  isUploaded: _uploaded['billbook_2']!,
                  onTap: () => _toggleUpload('billbook_2'),
                ),
                _UploadBox(
                  label: "Page 3",
                  isUploaded: _uploaded['billbook_3']!,
                  onTap: () => _toggleUpload('billbook_3'),
                ),
                _UploadBox(
                  label: "Page 4",
                  isUploaded: _uploaded['billbook_4']!,
                  onTap: () => _toggleUpload('billbook_4'),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // ── Submit button ─────────────────────────────────────────────
=======
                _buildUploadBox("Page 1"),
                _buildUploadBox("Page 2"),
                _buildUploadBox("Page 3"),
                _buildUploadBox("Page 4"),
              ],
            ),
            const SizedBox(height: 40),

            // Submit Button linked to Account Profile
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                  backgroundColor: _brandBlue,
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _isFormValid ? _onSubmit : null,
                child: const Text(
                  "Request for Verification",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

=======
                  backgroundColor: const Color(0xFF004687), // Uni-RIDE Blue
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // Finalizes verification request and moves to Profile
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AccountProfileScreen()),
                  );
                },
                child: const Text(
                  "Request for verfication", // Matching UI typo
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
}

// ── Upload box widget ─────────────────────────────────────────────────────────
class _UploadBox extends StatelessWidget {
  final String label;
  final bool isUploaded;
  final VoidCallback onTap;

  const _UploadBox({
    required this.label,
    required this.isUploaded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isUploaded
                    ? const Color(0xFF004687).withOpacity(0.08)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isUploaded
                      ? const Color(0xFF004687)
                      : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Icon(
                  isUploaded ? Icons.check_circle : Icons.add,
                  size: 30,
                  color: isUploaded
                      ? const Color(0xFF004687)
                      : Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isUploaded
                  ? const Color(0xFF004687)
                  : Colors.grey,
              fontWeight: isUploaded
                  ? FontWeight.w600
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
=======

  Widget _buildNumberInput(String hint) {
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
        AspectRatio(
          aspectRatio: 1.5,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(child: Icon(Icons.add, size: 30)),
          ),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
}