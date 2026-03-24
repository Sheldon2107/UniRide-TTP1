import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'constants.dart';
import 'home_dashboard.dart';
import 'driver_verification_screen.dart';
import 'car_rental_verification.dart';
import 'courier_service_selection.dart';
=======
import 'home_dashboard.dart';
import 'driver_verification_screen.dart'; 
import 'car_rental_verification.dart';
import 'courier_service_selection.dart'; // Added import for Courier flow
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

<<<<<<< HEAD
  static const List<_RoleOption> _roles = [
    _RoleOption(
      title: "Passenger",
      subtitle: "Book a ride around campus",
      icon: Icons.person_outline,
      type: _RoleType.passenger,
    ),
    _RoleOption(
      title: "Driver",
      subtitle: "Accept ride requests & earn",
      icon: Icons.directions_car_outlined,
      type: _RoleType.driver,
    ),
    _RoleOption(
      title: "Car Rental",
      subtitle: "Rent a vehicle for your trip",
      icon: Icons.car_rental_outlined,
      type: _RoleType.rental,
    ),
    _RoleOption(
      title: "Courier Services",
      subtitle: "Send or deliver packages",
      icon: Icons.local_shipping_outlined,
      type: _RoleType.courier,
    ),
  ];

  void _onRoleSelected(BuildContext context, _RoleType type) {
    switch (type) {
      case _RoleType.passenger:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeDashboard()),
        );
        break;
      case _RoleType.driver:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const DriverVerificationScreen()),
        );
        break;
      case _RoleType.rental:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const CarRentalVerification()),
        );
        break;
      case _RoleType.courier:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const CourierServiceSelection()),
        );
        break;
    }
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // ── Header ────────────────────────────────────────────────
            const Text(
              "Thank You!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Choose how you want to use the app",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 40),

            // ── Role cards ────────────────────────────────────────────
            Expanded(
              child: ListView.separated(
                itemCount: _roles.length,
                separatorBuilder: (_, _) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final role = _roles[index];
                  return _RoleCard(
                    role: role,
                    onTap: () => _onRoleSelected(context, role.type),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
=======
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const Text(
              "Thank You!", 
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 20),
            const Text(
              "Choose how you want to use the app", 
              textAlign: TextAlign.center
            ),
            const SizedBox(height: 50),
            
            // Updated role buttons with assigned roleTypes
            _roleButton(context, "Passenger"),
            _roleButton(context, "Driver", roleType: 'driver'), 
            _roleButton(context, "Car Rental", roleType: 'rental'),
            _roleButton(context, "Courier Services", roleType: 'courier'), // Updated roleType
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
}

// ── Role card widget ──────────────────────────────────────────────────────────
class _RoleCard extends StatelessWidget {
  final _RoleOption role;
  final VoidCallback onTap;

  const _RoleCard({required this.role, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6),
          ],
        ),
        child: Row(
          children: [
            // ── Icon container ──────────────────────────────────────
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.brandBlue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                role.icon,
                color: AppColors.brandBlue,
                size: 26,
              ),
            ),

            const SizedBox(width: 16),

            // ── Text ────────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    role.subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // ── Arrow ────────────────────────────────────────────────
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
            ),
          ],
=======

  Widget _roleButton(BuildContext context, String title, {String? roleType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF004687), // Uni-RIDE Blue
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            if (roleType == 'driver') {
              // Redirects to Driver Verification 1/3
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const DriverVerificationScreen())
              );
            } else if (roleType == 'rental') {
              // Redirects to Car Rental Verification 1/3
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const CarRentalVerification())
              );
            } else if (roleType == 'courier') {
              // Redirects to Courier Service choice (Send Package / Become Courier)
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const CourierServiceSelection())
              );
            } else {
              // Standard navigation to Home for Passenger
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const HomeDashboard())
              );
            }
          },
          child: Text(
            title, 
            style: const TextStyle(color: Colors.white, fontSize: 16)
          ),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
        ),
      ),
    );
  }
<<<<<<< HEAD
}

// ── Data models ───────────────────────────────────────────────────────────────
enum _RoleType { passenger, driver, rental, courier }

class _RoleOption {
  final String title;
  final String subtitle;
  final IconData icon;
  final _RoleType type;

  const _RoleOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.type,
  });
=======
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
}