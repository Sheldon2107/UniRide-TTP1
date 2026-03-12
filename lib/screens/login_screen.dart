import 'package:flutter/material.dart';
// Ensure these paths match your actual file names in lib/screens/
import 'role_selection_screen.dart'; 
import 'join_screen.dart'; 

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            
            // --- LOGO SECTION ---
            Center(
              child: Image.asset(
                'assets/logo.png', 
                height: 120, 
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback icon if the asset is missing
                  return const Icon(
                    Icons.directions_car, 
                    size: 80, 
                    color: Color(0xFF004687), // Brand Blue
                  );
                },
              ),
            ),
            
            const SizedBox(height: 30),
            const Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 28, 
                fontWeight: FontWeight.bold, 
                color: Color(0xFF1A1A1A),
              ),
            ),
            const Text(
              "Log in to your verified student account",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            
            const SizedBox(height: 30),
            
            // --- INPUT FIELDS ---
            _buildTextField(
              label: "UTP EMAIL", 
              hint: "student@utp.edu.my", 
              icon: Icons.email_outlined,
            ),
            _buildTextField(
              label: "PASSWORD", 
              hint: "••••••••", 
              icon: Icons.lock_outline, 
              isPassword: true,
            ),
            
            // --- FORGOT PASSWORD ---
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Add forgot password logic here
                }, 
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color(0xFF2E7D32), // UTP Green
                    fontWeight: FontWeight.bold, 
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // --- LOGIN BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004687), // Brand Blue
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  // Navigate to Role Selection after login
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RoleSelectionScreen(),
                    ),
                  );
                },
                child: const Text(
                  "LOG IN",
                  style: TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 60),
            
            // --- FOOTER: NAVIGATE TO JOIN ---
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("New here? ", style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Join Screen
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const JoinScreen()),
                      );
                    },
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        color: Color(0xFF2E7D32), // UTP Green
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label, 
    required String hint, 
    required IconData icon, 
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label, 
            style: const TextStyle(
              fontSize: 10, 
              fontWeight: FontWeight.bold, 
              color: Colors.grey,
            ),
          ),
          TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon, size: 20, color: const Color(0xFF004687)),
              suffixIcon: isPassword 
                  ? IconButton(
                      icon: const Icon(Icons.visibility_outlined, size: 20),
                      onPressed: () {
                        // Logic for password toggle can be added with a StatefulWidget
                      },
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF004687)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}