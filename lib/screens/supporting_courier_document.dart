import 'package:flutter/material.dart';
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              ],
            ),

            const SizedBox(height: 30),
            Divider(color: Colors.grey.withOpacity(0.2)),
            const SizedBox(height: 24),

            // ── Billbook section ─────────────────────────────────────
            _buildSectionHeader(
              icon: Icons.description_outlined,
              title: "Vehicle Ownership (Billbook)",
              subtitle: "Upload up to 4 pages — optional but recommended",
            ),
            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
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
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
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
        ],
      ),
    );
  }
}