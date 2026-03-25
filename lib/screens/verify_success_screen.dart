import 'package:flutter/material.dart';
import 'constants.dart';
import 'driver_home_dashboard.dart';
import 'home_dashboard.dart';
import 'login_screen.dart';
import 'car_rental_dashboard.dart';
import 'courier_home_dashboard.dart';

enum VerifySuccessMode {
  driverApproval,
  carRentalApproval,
  login,
  emailVerified,
  courierApproval,
}

class VerifySuccessScreen extends StatelessWidget {
  final VerifySuccessMode mode;
  final String title;
  final String subtitle;

  final String? firstName;
  final String? lastName;
  final String? vehicleModel;
  final String? numberPlate;
  final double? rentalPricePerDay;

  const VerifySuccessScreen({
    super.key,
    required this.mode,
    required this.title,
    required this.subtitle,
    this.firstName,
    this.lastName,
    this.vehicleModel,
    this.numberPlate,
    this.rentalPricePerDay,
  });

  void _onContinue(BuildContext context) {
    switch (mode) {
      case VerifySuccessMode.driverApproval:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => DriverHomeDashboard(
              firstName: firstName ?? "",
              lastName: lastName ?? "",
              vehicleModel: vehicleModel ?? "",
              numberPlate: numberPlate ?? "",
            ),
          ),
        );

      case VerifySuccessMode.carRentalApproval:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => CarRentalDashboard(
              firstName: firstName ?? "",
              lastName: lastName ?? "",
              vehicleModel: vehicleModel ?? "",
              numberPlate: numberPlate ?? "",
              rentalPricePerDay: rentalPricePerDay ?? 0.0,
            ),
          ),
        );

      case VerifySuccessMode.login:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeDashboard()),
        );

      case VerifySuccessMode.emailVerified:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );

      case VerifySuccessMode.courierApproval:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => CourierHomeDashboard(
              firstName: firstName ?? "",
              lastName: lastName ?? "",
            ),
          ),
          (route) => false,
        );
    }
  }

  Widget _buildIcon() {
    switch (mode) {
      case VerifySuccessMode.emailVerified:
        return const Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.shield, size: 140, color: AppColors.brandBlue),
            Icon(Icons.check, size: 60, color: AppColors.gold),
          ],
        );

      case VerifySuccessMode.carRentalApproval:
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.brandBlue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.car_rental,
              color: AppColors.brandBlue, size: 64),
        );

      case VerifySuccessMode.courierApproval:
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.brandBlue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.moped_rounded,
              color: AppColors.brandBlue, size: 64),
        );

      case VerifySuccessMode.driverApproval:
      case VerifySuccessMode.login:
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.verified_rounded,
              color: AppColors.success, size: 64),
        );
    }
  }

  String _buttonLabel() {
    switch (mode) {
      case VerifySuccessMode.emailVerified:
        return "Continue to Login";
      case VerifySuccessMode.driverApproval:
        return "Start Driving";
      case VerifySuccessMode.carRentalApproval:
        return "Go to Dashboard";
      case VerifySuccessMode.login:
        return "Continue";
      case VerifySuccessMode.courierApproval:
        return "Start Delivering";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            Center(child: _buildIcon()),
            const SizedBox(height: 32),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandBlue,
                  disabledBackgroundColor:
                      AppColors.brandBlue.withOpacity(0.4),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _onContinue(context),
                child: Text(
                  _buttonLabel(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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