import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:shared_preferences/shared_preferences.dart';
import 'verify_screen.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  static const Color _brandBlue = Color(0xFF004687);

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _fullNameController.text.trim().isNotEmpty &&
      _emailController.text.trim().isNotEmpty &&
      _passwordController.text.trim().isNotEmpty &&
      _confirmPasswordController.text.trim().isNotEmpty;

  bool _isValidUTPEmail(String email) {
    return email.toLowerCase().endsWith('@utp.edu.my');
  }

  bool _isStrongPassword(String password) {
    return password.length >= 8;
  }

  Future<void> _registerUser() async {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Validation
    if (!_isValidUTPEmail(email)) {
      _showSnackBar("Please use your UTP email (@utp.edu.my)");
      return;
    }

    if (!_isStrongPassword(password)) {
      _showSnackBar("Password must be at least 8 characters");
      return;
    }

    if (password != confirmPassword) {
      _showSnackBar("Passwords do not match");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('registered', true);
      await prefs.setString('fullName', fullName);
      await prefs.setString('email', email);
      await prefs.setString('password', password);

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VerifyScreen(email: email),
        ),
      );
    } catch (e) {
      if (mounted) _showSnackBar("Registration failed. Please try again.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
=======
// 1. Fixed import to point to the Verify Screen
import 'verify_screen.dart'; 

class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar with back button to return to LoginScreen
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
<<<<<<< HEAD
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // ── Logo ──────────────────────────────────────────────────
            Center(
              child: Image.asset(
                'assets/logo.png',
                height: 120,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.directions_car,
                  size: 80,
                  color: _brandBlue,
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "Join Uni-Ride",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
=======
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20), 
            Center(
              child: _buildLogo(),
            ),
            const Text(
              "Join Uni-Ride",
              style: TextStyle(
                fontSize: 28, 
                fontWeight: FontWeight.bold, 
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                color: Color(0xFF1A1A1A),
              ),
            ),
            const Text(
              "The exclusive mobility platform for UTP",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
<<<<<<< HEAD

            const SizedBox(height: 30),

            // ── Fields ────────────────────────────────────────────────
            _FormField(
              label: "FULL NAME",
              hint: "Enter your full name",
              controller: _fullNameController,
              icon: Icons.person_outline,
              onChanged: (_) => setState(() {}),
            ),
            _FormField(
              label: "UTP EMAIL",
              hint: "yourname@utp.edu.my",
              controller: _emailController,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              onChanged: (_) => setState(() {}),
            ),
            _FormField(
              label: "PASSWORD",
              hint: "Min. 8 characters",
              controller: _passwordController,
              icon: Icons.lock_outline,
              isPassword: true,
              obscureText: _obscurePassword,
              onToggleObscure: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
              onChanged: (_) => setState(() {}),
            ),
            _FormField(
              label: "CONFIRM PASSWORD",
              hint: "Re-enter your password",
              controller: _confirmPasswordController,
              icon: Icons.lock_outline,
              isPassword: true,
              obscureText: _obscureConfirm,
              onToggleObscure: () =>
                  setState(() => _obscureConfirm = !_obscureConfirm),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 40),

            // ── Submit button ─────────────────────────────────────────
=======
            const SizedBox(height: 30),
            
            _buildTextField(label: "FULL NAME", hint: "Enter your full name", icon: Icons.person_outline),
            _buildTextField(label: "PASSWORD", hint: "••••••••", icon: Icons.lock_outline, isPassword: true),
            _buildTextField(label: "CONFIRM PASSWORD", hint: "••••••••", icon: Icons.lock_outline, isPassword: true),
            _buildTextField(label: "UTP EMAIL", hint: "yourname@utp.edu.my", icon: Icons.email_outlined),
            
            const SizedBox(height: 40),
            
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                  backgroundColor: _brandBlue,
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed:
                    (_isFormValid && !_isLoading) ? _registerUser : null,
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
                        "CREATE ACCOUNT",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),

=======
                  backgroundColor: const Color(0xFF004687), // Brand Blue
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // 2. Fixed: Navigate immediately to VerifyScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VerifyScreen()),
                  );
                },
                child: const Text(
                  "CREATE ACCOUNT", 
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
}

// ── Reusable form field ───────────────────────────────────────────────────────
class _FormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;

  const _FormField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.icon,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleObscure,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
=======

  Widget _buildLogo() {
    return Image.asset(
      'assets/logo.png', 
      height: 120, 
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback if logo.png is missing from assets
        return const Icon(
          Icons.directions_car, 
          size: 80, 
          color: Color(0xFF004687),
        );
      },
    );
  }

  Widget _buildTextField({
    required String label, 
    required String hint, 
    required IconData icon, 
    bool isPassword = false,
  }) {
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
<<<<<<< HEAD
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
=======
            label, 
            style: const TextStyle(
              fontSize: 10, 
              fontWeight: FontWeight.bold, 
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
              color: Colors.grey,
            ),
          ),
          TextField(
<<<<<<< HEAD
            controller: controller,
            obscureText: isPassword ? obscureText : false,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon, size: 20, color: const Color(0xFF004687)),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onPressed: onToggleObscure,
                    )
=======
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon, size: 20, color: const Color(0xFF004687)),
              suffixIcon: isPassword 
                  ? const Icon(Icons.visibility_off_outlined, size: 20) 
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                  : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}