import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'constants.dart';
import 'car_rental_rating_screen.dart';
import 'car_rental_listing_screen.dart';

class CarRentalReturnScreen extends StatefulWidget {
  final CarListing car;
  final double totalPrice;

  const CarRentalReturnScreen({
    super.key,
    required this.car,
    required this.totalPrice,
  });

  @override
  State<CarRentalReturnScreen> createState() =>
      _CarRentalReturnScreenState();
}

class _CarRentalReturnScreenState
    extends State<CarRentalReturnScreen> {
  final TextEditingController _notesController =
      TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final Map<String, File?> _returnPhotos = {
    'front': null,
    'back': null,
    'left': null,
    'right': null,
  };

  bool _isLoading = false;

  bool get _isFormValid =>
      _returnPhotos['front'] != null &&
      _returnPhotos['back'] != null;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto(String key) async {
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
              "Upload Return Photo",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined,
                  color: AppColors.brandBlue),
              title: const Text("Take a photo"),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(
                    source: ImageSource.camera, imageQuality: 80);
                if (image != null && mounted) {
                  setState(
                      () => _returnPhotos[key] = File(image.path));
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
                    source: ImageSource.gallery, imageQuality: 80);
                if (image != null && mounted) {
                  setState(
                      () => _returnPhotos[key] = File(image.path));
                }
              },
            ),
            if (_returnPhotos[key] != null)
              ListTile(
                leading: const Icon(Icons.delete_outline,
                    color: AppColors.error),
                title: const Text("Remove",
                    style: TextStyle(color: AppColors.error)),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _returnPhotos[key] = null);
                },
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _onConfirmReturn() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => CarRentalRatingScreen(
          car: widget.car,
          totalPrice: widget.totalPrice,
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
          "Return Vehicle",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Info banner ────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.brandBlue.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.brandBlue.withOpacity(0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline,
                      color: AppColors.brandBlue, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Please take photos of the vehicle before returning. Front and back are required.",
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.brandBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Vehicle Photos",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 12),

            // ── Photo grid ─────────────────────────────────────────────
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: [
                _PhotoBox(
                  label: "Front *",
                  file: _returnPhotos['front'],
                  onTap: () => _pickPhoto('front'),
                  isRequired: true,
                ),
                _PhotoBox(
                  label: "Back *",
                  file: _returnPhotos['back'],
                  onTap: () => _pickPhoto('back'),
                  isRequired: true,
                ),
                _PhotoBox(
                  label: "Left side",
                  file: _returnPhotos['left'],
                  onTap: () => _pickPhoto('left'),
                ),
                _PhotoBox(
                  label: "Right side",
                  file: _returnPhotos['right'],
                  onTap: () => _pickPhoto('right'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Notes ──────────────────────────────────────────────────
            const Text(
              "Additional Notes (optional)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Any damages, fuel level, etc...",
                hintStyle: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 13),
                filled: true,
                fillColor: AppColors.inputFill,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(14),
              ),
            ),

            const SizedBox(height: 32),

            // ── Confirm return button ──────────────────────────────────
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
                onPressed: (_isFormValid && !_isLoading)
                    ? _onConfirmReturn
                    : null,
                child: _isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const Text(
                        "Confirm Return",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoBox extends StatelessWidget {
  final String label;
  final File? file;
  final VoidCallback onTap;
  final bool isRequired;

  const _PhotoBox({
    required this.label,
    required this.file,
    required this.onTap,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasPhoto = file != null;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: hasPhoto
                    ? AppColors.brandBlue.withOpacity(0.06)
                    : AppColors.inputFill,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: hasPhoto
                      ? AppColors.brandBlue
                      : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: hasPhoto
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: Image.file(file!, fit: BoxFit.cover),
                    )
                  : Icon(
                      Icons.add_a_photo_outlined,
                      size: 28,
                      color: isRequired
                          ? AppColors.brandBlue
                          : AppColors.textSecondary,
                    ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: hasPhoto
                  ? AppColors.brandBlue
                  : AppColors.textSecondary,
              fontWeight: hasPhoto
                  ? FontWeight.w600
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}