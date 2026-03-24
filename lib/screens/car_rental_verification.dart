<<<<<<< HEAD
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'constants.dart';
import 'car_rental_vehicle_info.dart';

class CarRentalVerification extends StatefulWidget {
  const CarRentalVerification({super.key});

  @override
  State<CarRentalVerification> createState() => _CarRentalVerificationState();
}

class _CarRentalVerificationState extends State<CarRentalVerification> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  DateTime? _selectedDob;
  File? _profileImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _firstNameController.text.trim().isNotEmpty &&
      _lastNameController.text.trim().isNotEmpty &&
      _addressController.text.trim().isNotEmpty &&
      _selectedDob != null;

  String get _dobLabel {
    if (_selectedDob == null) return "Select date";
    return "${_selectedDob!.month.toString().padLeft(2, '0')}-"
        "${_selectedDob!.day.toString().padLeft(2, '0')}-"
        "${_selectedDob!.year}";
  }

  Future<void> _pickProfileImage() async {
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
              "Choose Profile Photo",
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
                  imageQuality: 80,
                );
                if (image != null && mounted) {
                  setState(() => _profileImage = File(image.path));
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
                  imageQuality: 80,
                );
                if (image != null && mounted) {
                  setState(() => _profileImage = File(image.path));
                }
              },
            ),
            if (_profileImage != null)
              ListTile(
                leading: const Icon(Icons.delete_outline,
                    color: AppColors.error),
                title: const Text(
                  "Remove photo",
                  style: TextStyle(color: AppColors.error),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _profileImage = null);
                },
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDob() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 21),
      firstDate: DateTime(1950),
      lastDate: DateTime(now.year - 18, now.month, now.day),
      helpText: "Select Date of Birth",
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
              primary: AppColors.brandBlue),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDob = picked);
  }

  void _onNext() {
    if (!_isFormValid) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CarRentalVehicleInfo(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          dob: _dobLabel,
          address: _addressController.text.trim(),
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
          icon: const Icon(Icons.arrow_back,
              color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Verification - 1/3",
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
            const SizedBox(height: 20),

            // ── Profile image picker ──────────────────────────────────
            Center(
              child: GestureDetector(
                onTap: _pickProfileImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                          (!kIsWeb && _profileImage != null)
                              ? FileImage(_profileImage!)
                              : null,
                      child: (_profileImage == null || kIsWeb)
                          ? const Icon(Icons.person,
                              size: 50, color: Colors.grey)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.brandBlue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "Click to Pick",
                style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary),
              ),
            ),

            const SizedBox(height: 30),

            // ── Name fields ───────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _InputField(
                    controller: _firstNameController,
                    hint: "Firstname",
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _InputField(
                    controller: _lastNameController,
                    hint: "Lastname",
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── DOB picker ────────────────────────────────────────────
            const Divider(),
            InkWell(
              onTap: _pickDob,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Date of Birth",
                      style: TextStyle(
                          color: AppColors.textSecondary),
                    ),
                    Row(
                      children: [
                        Text(
                          _dobLabel,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: _selectedDob == null
                                ? AppColors.textSecondary
                                : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.calendar_today,
                            size: 16,
                            color: AppColors.textSecondary),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),

            const SizedBox(height: 20),

            // ── Address ───────────────────────────────────────────────
            _InputField(
              controller: _addressController,
              hint: "Permanent Address",
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 40),

            // ── Next button ───────────────────────────────────────────
=======
import 'package:flutter/material.dart';
import 'car_rental_vehicle_info.dart'; // Import the second step

class CarRentalVerification extends StatelessWidget {
  const CarRentalVerification({super.key});

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
        title: const Text(
          "Verification- 1/3",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Profile Photo Picker
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(Icons.person, size: 50, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text("Click to Pick", style: TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Name Fields Row
            Row(
              children: [
                Expanded(child: _buildInputBox("Firstname")),
                const SizedBox(width: 15),
                Expanded(child: _buildInputBox("Lastname")),
              ],
            ),
            const SizedBox(height: 20),

            // Date of Birth Section
            const Divider(thickness: 1),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("DOB", style: TextStyle(fontSize: 14, color: Colors.black)),
                  Text("10-26-2016", style: TextStyle(fontSize: 14, color: Colors.black)),
                ],
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 20),

            // Address Field
            _buildInputBox("Permanent Address"),
            const SizedBox(height: 40),

            // Navigation Button
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _isFormValid ? _onNext : null,
                child: const Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
=======
                  backgroundColor: const Color(0xFF004687), // Uni-RIDE Blue
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Link to Step 2/3: Vehicle Information
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CarRentalVehicleInfo()),
                  );
                },
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
}

// ── Reusable input field ──────────────────────────────────────────────────────
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final void Function(String)? onChanged;

  const _InputField({
    required this.controller,
    required this.hint,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
            color: AppColors.textSecondary, fontSize: 14),
        filled: true,
        fillColor: AppColors.inputFill,
=======

  Widget _buildInputBox(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFF5F5F5), // Light grey input style
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
<<<<<<< HEAD
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 15, vertical: 15),
=======
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
      ),
    );
  }
}