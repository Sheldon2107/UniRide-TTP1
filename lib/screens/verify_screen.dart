import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/verify_success_screen.dart';
// 1. Import the success screen so the button knows where to go

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The back button is automatic because we used Navigator.push to get here
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView( // Added scroll view to prevent layout overflow
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Text("Verify Email", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("We've sent a 6-digit code to", textAlign: TextAlign.center),
            const Text("sheldon@email.com", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            
            // Code Input Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) => _buildCodeBox()),
            ),
            
            const SizedBox(height: 40),
            
            // 2. Updated the Register button to navigate to Success Screen
            _buildBlueButton("Register", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VerifySuccessScreen()),
              );
            }),
            
            const SizedBox(height: 15),
            
            // Resend button (Keep as placeholder for now)
            _buildBlueButton("Resend code in 00:45", () {
              // Logic for resending code goes here
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeBox() {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const TextField(
        textAlign: TextAlign.center, 
        keyboardType: TextInputType.number, 
        maxLength: 1, // Limit to one digit per box
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: "", // Hides the character counter
        ),
      ),
    );
  }

  Widget _buildBlueButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF004687), 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}