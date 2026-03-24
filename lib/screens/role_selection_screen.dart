import 'package:flutter/material.dart';

import 'constants.dart';
import 'home_dashboard.dart';
import 'driver_verification_screen.dart';
import 'car_rental_verification.dart';
import 'courier_service_selection.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

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
          MaterialPageRoute(builder: (_) => const DriverVerificationScreen()),
        );
        break;

      case _RoleType.rental:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CarRentalVerification()),
        );
        break;

      case _RoleType.courier:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CourierServiceSelection()),
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
            const SizedBox(height: 20),

            // Header
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

            // Role Cards
            Expanded(
              child: ListView.separated(
                itemCount: _roles.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final role = _roles[index];
                  return _RoleCard(
                    role: role,
                    onTap: () => _onRoleSelected(context, role.type),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Role Card Widget
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
          color: Colors.white,                    // Better contrast
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.brandBlue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                role.icon,
                color: AppColors.brandBlue,
                size: 28,
              ),
            ),

            const SizedBox(width: 18),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    role.subtitle,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }
}

// Data Models
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
}