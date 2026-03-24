import 'package:flutter/material.dart';
import 'verify_success_screen.dart';

class VerifyScreen extends StatefulWidget {
  final String email;

  const VerifyScreen({super.key, required this.email});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen>
    with SingleTickerProviderStateMixin {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(6, (_) => FocusNode());

  static const Color _brandBlue = Color(0xFF004687);
  bool _isLoading = false;
  bool _showBanner = false;
  late String _selectedCode;

  // ── Pool of 10 valid codes ──────────────────────────────────────────
  static const List<String> _validCodes = [
    "482910",
    "371624",
    "905813",
    "264738",
    "198427",
    "637291",
    "820564",
    "143879",
    "759032",
    "416385",
  ];

  late AnimationController _bannerController;
  late Animation<Offset> _bannerAnimation;

  @override
  void initState() {
    super.initState();

    // Pick a random code from the pool
    _selectedCode = (_validCodes.toList()..shuffle()).first;

    // Setup banner slide animation
    _bannerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _bannerAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _bannerController,
      curve: Curves.easeOut,
    ));

    // Show banner after short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _showBanner = true);
        _bannerController.forward();

        // Auto hide after 5 seconds
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) _dismissBanner();
        });
      }
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _bannerController.dispose();
    super.dispose();
  }

  void _dismissBanner() {
    _bannerController.reverse().then((_) {
      if (mounted) setState(() => _showBanner = false);
    });
  }

  String get _enteredCode =>
      _controllers.map((c) => c.text).join();

  bool get _isComplete => _enteredCode.length == 6;

  void _onDigitChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  Future<void> _verifyCode() async {
    if (!_isComplete) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isLoading = false);

    // Any of the 10 codes is valid
    if (_validCodes.contains(_enteredCode)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const VerifySuccessScreen(
            mode: VerifySuccessMode.emailVerified,
            title: "Email Verified Successfully!",
            subtitle: "Your account is now ready to use.",
          ),
        ),
      );
    } else {
      // Shake the boxes on wrong code
      _clearBoxes();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid code. Please check your email."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _clearBoxes() {
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes[0].requestFocus();
    setState(() {});
  }

  void _resendCode() {
    // Pick a new random code
    setState(() {
      _selectedCode = (_validCodes.toList()..shuffle()).first;
      _showBanner = true;
    });
    _clearBoxes();
    _bannerController.reset();
    _bannerController.forward();

    // Auto hide after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) _dismissBanner();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("New code sent!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // ── Main content ────────────────────────────────────────────
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // ── Icon ──────────────────────────────────────────────
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: _brandBlue.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mark_email_unread_outlined,
                      color: _brandBlue,
                      size: 40,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Verify your email",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "We sent a 6-digit code to\n${widget.email}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 36),

                // ── OTP boxes ──────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 48,
                      height: 56,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        onChanged: (val) => _onDigitChanged(index, val),
                        decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: _brandBlue,
                              width: 1.5,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 32),

                // ── Verify button ──────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _brandBlue,
                      disabledBackgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed:
                        (_isComplete && !_isLoading) ? _verifyCode : null,
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
                            "VERIFY",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 16),

                // ── Resend ─────────────────────────────────────────────
                Center(
                  child: TextButton(
                    onPressed: _resendCode,
                    child: const Text(
                      "Didn't receive a code? Resend",
                      style: TextStyle(color: _brandBlue),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Floating notification banner ────────────────────────────
          if (_showBanner)
            Positioned(
              top: 0,
              left: 16,
              right: 16,
              child: SlideTransition(
                position: _bannerAnimation,
                child: SafeArea(
                  child: GestureDetector(
                    onTap: _dismissBanner,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Email icon
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _brandBlue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.email_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "UniRide • Email Verification",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Your code: $_selectedCode",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Dismiss
                          GestureDetector(
                            onTap: _dismissBanner,
                            child: const Icon(
                              Icons.close,
                              color: Colors.white54,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}