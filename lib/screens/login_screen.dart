import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'role_selection_screen.dart';
import 'join_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isRegistered = false;
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _checkRegistration();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _emailController.text.trim().isNotEmpty &&
      _passwordController.text.trim().isNotEmpty;

  Future<void> _checkRegistration() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _isRegistered = prefs.getBool('registered') ?? false;
    });
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (!_isRegistered) {
      _showSnackBar("Please register first!");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final storedEmail = prefs.getString('email') ?? '';
      final storedPassword = prefs.getString('password') ?? '';

      if (email == storedEmail && password == storedPassword) {
        await prefs.setString("name", email.split("@")[0]);

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const RoleSelectionScreen(),
          ),
        );
      } else {
        if (mounted) _showSnackBar("Invalid email or password");
      }
    } catch (e) {
      if (mounted) _showSnackBar("Login failed. Please try again.");
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
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
<<<<<<< HEAD

            // ── Logo ──────────────────────────────────────────────────
            Center(
              child: Image.asset(
                'assets/logo.png',
                height: 120,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.directions_car,
                  size: 80,
                  color: AppColors.brandBlue,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ── Title ─────────────────────────────────────────────────
            const Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
=======
            
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
              ),
            ),
            const Text(
              "Log in to your verified student account",
<<<<<<< HEAD
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 30),

            // ── Email field ───────────────────────────────────────────
            _LoginField(
              controller: _emailController,
              label: "UTP EMAIL",
              hint: "student@utp.edu.my",
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              onChanged: (_) => setState(() {}),
            ),

            // ── Password field ────────────────────────────────────────
            _LoginField(
              controller: _passwordController,
              label: "PASSWORD",
              hint: "••••••••",
              icon: Icons.lock_outline,
              isPassword: true,
              obscureText: _obscurePassword,
              onToggleObscure: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
              onChanged: (_) => setState(() {}),
            ),

            // ── Forgot password ───────────────────────────────────────
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
<<<<<<< HEAD
                  _showSnackBar("Forgot password feature coming soon!");
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: AppColors.brandBlue,
                    fontWeight: FontWeight.bold,
=======
                  // Add forgot password logic here
                }, 
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color(0xFF2E7D32), // UTP Green
                    fontWeight: FontWeight.bold, 
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                    fontSize: 12,
                  ),
                ),
              ),
            ),
<<<<<<< HEAD

            const SizedBox(height: 20),

            // ── Login button ──────────────────────────────────────────
=======
            
            const SizedBox(height: 20),
            
            // --- LOGIN BUTTON ---
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                  backgroundColor: AppColors.brandBlue,
                  disabledBackgroundColor:
                      AppColors.brandBlue.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: (_isFormValid && !_isLoading) ? _login : null,
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

            // ── Create account ────────────────────────────────────────
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
<<<<<<< HEAD
                  const Text(
                    "New here? ",
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const JoinScreen()),
                    ),
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        color: AppColors.brandBlue,
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
<<<<<<< HEAD

=======
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
}

// ── Reusable login field ──────────────────────────────────────────────────────
class _LoginField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;

  const _LoginField({
    required this.controller,
    required this.label,
    required this.hint,
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
              color: AppColors.textSecondary,
            ),
          ),
          TextField(
            controller: controller,
            obscureText: isPassword ? obscureText : false,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(
                icon,
                size: 20,
                color: AppColors.brandBlue,
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: onToggleObscure,
=======
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
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              enabledBorder: const UnderlineInputBorder(
<<<<<<< HEAD
                borderSide: BorderSide(color: AppColors.textSecondary),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.brandBlue),
=======
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF004687)),
>>>>>>> 63b3c4e590e0111a387a3dc8d4ce2b08b8651ad2
              ),
            ),
          ),
        ],
      ),
    );
  }
}