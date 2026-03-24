import 'package:flutter/material.dart';
import 'constants.dart';

class AccountProfileScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String dob;
  final String address;
  final String vehicleCategory;
  final String vehicleModel;
  final String numberPlate;
  final String licenseNumber;

  const AccountProfileScreen({
    super.key,
    this.firstName = "",
    this.lastName = "",
    this.dob = "",
    this.address = "",
    this.vehicleCategory = "",
    this.vehicleModel = "",
    this.numberPlate = "",
    this.licenseNumber = "",
  });

  String get _fullName {
    final name = "$firstName $lastName".trim();
    return name.isEmpty ? "Passenger" : name;
  }

  bool get _hasVehicleInfo =>
      vehicleModel.isNotEmpty &&
      vehicleCategory.isNotEmpty &&
      numberPlate.isNotEmpty;

  void _onSignOut(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
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
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.textPrimary,
        unselectedItemColor: AppColors.textSecondary,
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Account"),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          // ── User header ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.cyanAccent,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _fullName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Text(
                        "+60 1234411231",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // ── Rating badge ──────────────────────────────
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.inputFill,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "5.0 ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              size: 14,
                              color: AppColors.gold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Roadway Cash card ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Roadway Cash",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "RM20.90",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          const Divider(thickness: 1, indent: 24, endIndent: 24),

          // ── Vehicle info summary ──────────────────────────────────────
          if (_hasVehicleInfo) ...[
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.directions_car_outlined,
                    size: 14,
                    color: AppColors.brandBlue,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "$vehicleModel ($vehicleCategory) · $numberPlate",
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1, indent: 24, endIndent: 24),
          ],

          // ── Settings list ─────────────────────────────────────────────
          _ProfileTile(
            icon: Icons.person_outline,
            title: "Personal details",
            onTap: () {},
          ),
          _ProfileTile(
            icon: Icons.settings_outlined,
            title: "Settings and privacy",
            onTap: () {},
          ),
          _ProfileTile(
            icon: Icons.access_time,
            title: "Trips details",
            onTap: () {},
          ),

          const Spacer(),

          // ── Sign out button ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandBlue,
                  disabledBackgroundColor:
                      AppColors.brandBlue.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => _onSignOut(context),
                child: const Text(
                  "Sign out",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Reusable profile tile ─────────────────────────────────────────────────────
class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.inputFill,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.textPrimary),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.textSecondary,
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    );
  }
}