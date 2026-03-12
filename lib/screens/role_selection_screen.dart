import 'package:flutter/material.dart';
import 'home_dashboard.dart';
import 'driver_verification_screen.dart'; 
import 'car_rental_verification.dart';
import 'courier_service_selection.dart'; // Added import for Courier flow

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

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
          ],
        ),
      ),
    );
  }

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
        ),
      ),
    );
  }
}