import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'constants.dart';
import 'car_rental_supporting_docs.dart';

class CarRentalVehicleInfo extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String dob;
  final String address;

  const CarRentalVehicleInfo({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.address,
  });

  @override
  State<CarRentalVehicleInfo> createState() => _CarRentalVehicleInfoState();
}

class _CarRentalVehicleInfoState extends State<CarRentalVehicleInfo> {
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _plateController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String? _selectedCategory;
  File? _vehicleImage;

  static const List<String> _categories = [
    "Car",
    "SUV",
    "Van",
    "Pickup Truck",
    "MPV",
  ];

  @override
  void dispose() {
    _modelController.dispose();
    _plateController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _selectedCategory != null &&
      _modelController.text.trim().isNotEmpty &&
      _plateController.text.trim().isNotEmpty &&
      _priceController.text.trim().isNotEmpty;

  Future<void> _pickVehicleImage() async {
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
              "Choose Vehicle Photo",
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
                  setState(() => _vehicleImage = File(image.path));
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
                  setState(() => _vehicleImage = File(image.path));
                }
              },
            ),
            if (_vehicleImage != null)
              ListTile(
                leading: const Icon(Icons.delete_outline,
                    color: AppColors.error),
                title: const Text(
                  "Remove photo",
                  style: TextStyle(color: AppColors.error),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _vehicleImage = null);
                },
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _onNext() {
    if (!_isFormValid) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CarRentalSupportingDocs(
          firstName: widget.firstName,
          lastName: widget.lastName,
          dob: widget.dob,
          address: widget.address,
          vehicleCategory: _selectedCategory!,
          vehicleModel: _modelController.text.trim(),
          numberPlate: _plateController.text.trim(),
          rentalPricePerDay:
              double.tryParse(_priceController.text.trim()) ?? 0.0,
          description: _descriptionController.text.trim(),
        ),
      ),
    );
  }

  static const Widget _uploadPlaceholder = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.add, size: 40, color: AppColors.textPrimary),
      SizedBox(height: 8),
      Text(
        "Upload vehicle image",
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
      ),
    ],
  );

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
          "Verification - 2/3",
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
              "Vehicle Information",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 25),

            // ── Vehicle image upload ──────────────────────────────────
            GestureDetector(
              onTap: _pickVehicleImage,
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _vehicleImage != null
                        ? AppColors.brandBlue
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: _vehicleImage != null
                    ? AppImage.file(
                        _vehicleImage,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.circular(11),
                        fallback: _uploadPlaceholder,
                      )
                    : _uploadPlaceholder,
              ),
            ),

            const SizedBox(height: 30),

            // ── Category ──────────────────────────────────────────────
            const Text(
              "Category",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  hint: const Text(
                    "Select one option",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: AppColors.textPrimary),
                  items: _categories
                      .map((c) =>
                          DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (val) =>
                      setState(() => _selectedCategory = val),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── Model name ────────────────────────────────────────────
            const Text(
              "Model name",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _InputField(
              controller: _modelController,
              hint: "e.g. Perodua Myvi 2022",
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 20),

            // ── Number plate ──────────────────────────────────────────
            const Text(
              "Number plate",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _InputField(
              controller: _plateController,
              hint: "e.g. ABC 1234",
              onChanged: (_) => setState(() {}),
              textCapitalization: TextCapitalization.characters,
            ),

            const SizedBox(height: 20),

            // ── Rental price ──────────────────────────────────────────
            const Text(
              "Rental price per day (RM)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _InputField(
              controller: _priceController,
              hint: "e.g. 150",
              onChanged: (_) => setState(() {}),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            // ── Description ───────────────────────────────────────────
            const Text(
              "Description (optional)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText:
                    "e.g. Well maintained, full tank, free pickup...",
                hintStyle: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
                filled: true,
                fillColor: AppColors.inputFill,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(15),
              ),
            ),

            const SizedBox(height: 40),

            // ── Next button ───────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
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
          ],
        ),
      ),
    );
  }
}

// ── Reusable input field ──────────────────────────────────────────────────────
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final void Function(String)? onChanged;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;

  const _InputField({
    required this.controller,
    required this.hint,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
        ),
        filled: true,
        fillColor: AppColors.inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 15, vertical: 15),
      ),
    );
  }
}