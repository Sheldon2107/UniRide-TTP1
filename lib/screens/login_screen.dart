import 'package:flutter/material.dart';
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
                'assets/logo.png', // Updated to match your renamed file
                height: 120, // Adjusted height for visibility
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback icon if the asset still fails to load
                  return const Icon(
                    Icons.directions_car, 
                    size: 80, 
                    color: Color(0xFF004687),
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
            
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {}, 
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color(0xFF2E7D32), 
                    fontWeight: FontWeight.bold, 
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004687), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
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
            
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("New here? ", style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const JoinScreen()),
                      );
                    },
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        color: Color(0xFF2E7D32), 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
              prefixIcon: Icon(icon, size: 20),
              suffixIcon: isPassword 
                  ? const Icon(Icons.visibility_outlined, size: 20) 
                  : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}