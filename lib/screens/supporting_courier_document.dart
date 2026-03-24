import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'constants.dart';
import 'verify_success_screen.dart';

class SupportingCourierDocumentScreen extends StatefulWidget {
  const SupportingCourierDocumentScreen({super.key});

  @override
  State<SupportingCourierDocumentScreen> createState() =>
      _SupportingCourierDocumentScreenState();
}

class _SupportingCourierDocumentScreenState
    extends State<SupportingCourierDocumentScreen> {
  final TextEditingController _licenseController = TextEditingController();

  // Track which upload slots have been filled
  final Map<String, bool> _uploaded = {
    'license_front': false,
    'license_back': false,
    'billbook_1': false,
    'billbook_2': false,
    'billbook_3': false,
    'billbook_4': false,
  };

  bool get _canSubmit =>
      _licenseController.text.trim().isNotEmpty &&
      _uploaded['license_front']! &&
      _uploaded['license_back']!;

  @override
  void initState() {
    super.initState();
    _licenseController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _licenseController.dispose();
    super.dispose();
  }

  void _onUploadTap(String key) {
    // TODO: hook up image_picker here
    setState(() => _uploaded[key] = true);
  }

  void _submit() {
    if (!_canSubmit) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const VerifySuccessScreen(
          mode: VerifySuccessMode.courierApproval, title: '', subtitle: '',
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
            const Text(
              "Supporting Documents",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Required to verify you as a courier",
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 30),

            // ── License section ──────────────────────────────────────
            _buildSectionHeader(
              icon: Icons.badge_outlined,
              title: "Driver's License",
              subtitle: "Enter your license number and upload both sides",
            ),
            const SizedBox(height: 14),

            // License number field
            TextField(
              controller: _licenseController,
              decoration: InputDecoration(
                hintText: "Enter license number",
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
            ),
            const SizedBox(height: 16),

            // License front + back
            Row(
              children: [
                Expanded(
                  child: _buildUploadBox(
                    key: 'license_front',
                    label: "Front",
                    required: true,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _buildUploadBox(
                    key: 'license_back',
                    label: "Back",
                    required: true,
                  ),
                ),
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
              ],
            ),

            const SizedBox(height: 30),
<<<<<<< HEAD
            Divider(color: Colors.grey.withOpacity(0.2)),
            const SizedBox(height: 24),

            // ── Billbook section ─────────────────────────────────────
            _buildSectionHeader(
              icon: Icons.description_outlined,
              title: "Vehicle Ownership (Billbook)",
              subtitle: "Upload up to 4 pages — optional but recommended",
            ),
            const SizedBox(height: 16),

=======
            const Divider(),
            const SizedBox(height: 20),

            // Billbook/Vehicle Ownership Section
            const Text("Upload your billbook photo", style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 15),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
<<<<<<< HEAD
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.2,
              children: [
                _buildUploadBox(key: 'billbook_1', label: "Page 1"),
                _buildUploadBox(key: 'billbook_2', label: "Page 2"),
                _buildUploadBox(key: 'billbook_3', label: "Page 3"),
                _buildUploadBox(key: 'billbook_4', label: "Page 4"),
              ],
            ),

            const SizedBox(height: 16),

            // Required fields note
            Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  "* License number and both license photos are required",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary.withOpacity(0.8),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // ── Submit button ────────────────────────────────────────
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                  backgroundColor: _canSubmit
                      ? AppColors.brandBlue
                      : AppColors.brandBlue.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                onPressed: _canSubmit ? _submit : null,
                child: const Text(
                  "Request Verification",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.brandBlue.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.brandBlue, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUploadBox({
    required String key,
    required String label,
    bool required = false,
  }) {
    final bool isUploaded = _uploaded[key] ?? false;

    return GestureDetector(
      onTap: () => _onUploadTap(key),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 100,
            decoration: BoxDecoration(
              color: isUploaded
                  ? AppColors.brandBlue.withOpacity(0.08)
                  : AppColors.brandBlue.withOpacity(0.04),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isUploaded
                    ? AppColors.brandBlue.withOpacity(0.4)
                    : AppColors.brandBlue.withOpacity(0.15),
              ),
            ),
            child: Center(
              child: isUploaded
                  ? const Icon(
                      Icons.check_circle,
                      size: 36,
                      color: AppColors.brandBlue,
                    )
                  : Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 36,
                      color: AppColors.brandBlue.withOpacity(0.4),
                    ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              if (required)
                const Text(
                  " *",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
        ],
      ),
    );
  }
}