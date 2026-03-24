<<<<<<< HEAD
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'constants.dart';
import 'verify_success_screen.dart';
import 'verification_pending_screen.dart';

class CarRentalSupportingDocs extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String dob;
  final String address;
  final String vehicleCategory;
  final String vehicleModel;
  final String numberPlate;
  final double rentalPricePerDay;
  final String description;

  const CarRentalSupportingDocs({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.address,
    required this.vehicleCategory,
    required this.vehicleModel,
    required this.numberPlate,
    required this.rentalPricePerDay,
    required this.description,
  });

  @override
  State<CarRentalSupportingDocs> createState() =>
      _CarRentalSupportingDocsState();
}

class _CarRentalSupportingDocsState
    extends State<CarRentalSupportingDocs> {
  final TextEditingController _licenseController =
      TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final Map<String, File?> _uploadedImages = {
    'license_front': null,
    'license_back': null,
    'billbook_1': null,
    'billbook_2': null,
    'billbook_3': null,
    'billbook_4': null,
  };

  @override
  void dispose() {
    _licenseController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _licenseController.text.trim().isNotEmpty &&
      _uploadedImages['license_front'] != null &&
      _uploadedImages['license_back'] != null &&
      _uploadedImages['billbook_1'] != null &&
      _uploadedImages['billbook_2'] != null &&
      _uploadedImages['billbook_3'] != null &&
      _uploadedImages['billbook_4'] != null;

  Future<void> _pickImage(String key) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Upload Document",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined,
                  color: AppColors.brandBlue),
              title: const Text("Take a photo"),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 85,
                );
                if (image != null && mounted) {
                  setState(
                      () => _uploadedImages[key] = File(image.path));
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined,
                  color: AppColors.brandBlue),
              title: const Text("Choose from gallery"),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 85,
                );
                if (image != null && mounted) {
                  setState(
                      () => _uploadedImages[key] = File(image.path));
                }
              },
            ),
            if (_uploadedImages[key] != null)
              ListTile(
                leading: const Icon(Icons.delete_outline,
                    color: AppColors.error),
                title: const Text(
                  "Remove",
                  style: TextStyle(color: AppColors.error),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _uploadedImages[key] = null);
                },
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
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
          successMode: VerifySuccessMode.carRentalApproval,
          rentalPricePerDay: widget.rentalPricePerDay,
        ),
      ),
    );
  }
=======
import 'package:flutter/material.dart';
// Import your final confirmation or dashboard screen
// import 'car_rental_confirmation.dart'; 

class CarRentalSupportingDocs extends StatelessWidget {
  const CarRentalSupportingDocs({super.key});
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Verification - 3/3",
          style: TextStyle(
            color: AppColors.textPrimary,
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

            const Text(
              "Supporting Documents",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 25),

            // ── License section ───────────────────────────────────────
            const Text(
              "Upload your license photo",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _licenseController,
              onChanged: (_) => setState(() {}),
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                hintText: "Enter license number",
                hintStyle: const TextStyle(
                    color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.inputFill,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _UploadBox(
                    label: "Front",
                    file: _uploadedImages['license_front'],
                    onTap: () => _pickImage('license_front'),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _UploadBox(
                    label: "Back",
                    file: _uploadedImages['license_back'],
                    onTap: () => _pickImage('license_back'),
                  ),
                ),
              ],
            ),

=======
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
            
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            const SizedBox(height: 25),
            const Divider(),
            const SizedBox(height: 25),

<<<<<<< HEAD
            // ── Billbook section ──────────────────────────────────────
            const Text(
              "Upload your billbook photo",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 15),

=======
            // Billbook Photo Section
            const Text("Upload your billbook photo", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 15),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1.2,
              children: [
<<<<<<< HEAD
                _UploadBox(
                  label: "Page 1",
                  file: _uploadedImages['billbook_1'],
                  onTap: () => _pickImage('billbook_1'),
                ),
                _UploadBox(
                  label: "Page 2",
                  file: _uploadedImages['billbook_2'],
                  onTap: () => _pickImage('billbook_2'),
                ),
                _UploadBox(
                  label: "Page 3",
                  file: _uploadedImages['billbook_3'],
                  onTap: () => _pickImage('billbook_3'),
                ),
                _UploadBox(
                  label: "Page 4",
                  file: _uploadedImages['billbook_4'],
                  onTap: () => _pickImage('billbook_4'),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // ── Submit button ─────────────────────────────────────────
=======
                _buildUploadBox("Page 1"),
                _buildUploadBox("Page 2"),
                _buildUploadBox("Page 3"),
                _buildUploadBox("Page 4"),
              ],
            ),
            
            const SizedBox(height: 40),

            // Request Verification Button
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                  backgroundColor: AppColors.brandBlue,
                  disabledBackgroundColor:
                      AppColors.brandBlue.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _isFormValid ? _onSubmit : null,
                child: const Text(
                  "Request for Verification",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

=======
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
  final File? file;
  final VoidCallback onTap;

  const _UploadBox({
    required this.label,
    required this.file,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage = file != null;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: hasImage
                  ? AppColors.brandBlue.withOpacity(0.06)
                  : AppColors.inputFill,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasImage
                    ? AppColors.brandBlue
                    : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: hasImage
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Image.file(file!, fit: BoxFit.cover),
                  )
                : const Icon(
                    Icons.add,
                    size: 30,
                    color: AppColors.textSecondary,
                  ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: hasImage
                  ? AppColors.brandBlue
                  : AppColors.textSecondary,
              fontWeight:
                  hasImage ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
=======

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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
}