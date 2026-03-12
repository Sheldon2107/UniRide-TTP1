import 'package:flutter/material.dart';
import 'login_screen.dart';

class VerifySuccessScreen extends StatelessWidget {
  const VerifySuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar is transparent and non-interactive to keep user on this screen
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Centered Verified Shield Icon matching Uni-Ride branding
            const Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.shield,
                    size: 140,
                    color: Color(0xFF004687), // Brand Blue
                  ),
                  Icon(
                    Icons.check,
                    size: 60,
                    color: Color(0xFFFFD700), // Gold checkmark
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Email Verified Successfully!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Your account is now ready to use.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey, 
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 80),
            
            // Primary Action Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004687), // Brand Blue
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  // Clears navigation stack so user cannot go back to verification
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
                child: const Text(
                  "Continue to Login", 
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
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