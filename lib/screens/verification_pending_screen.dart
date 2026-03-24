import 'package:flutter/material.dart';
import 'constants.dart';
import 'verify_success_screen.dart';

class VerificationPendingScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String dob;
  final String address;
  final String vehicleCategory;
  final String vehicleModel;
  final String numberPlate;
  final String licenseNumber;
  final VerifySuccessMode successMode;
  final double rentalPricePerDay;

  const VerificationPendingScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.address,
    required this.vehicleCategory,
    required this.vehicleModel,
    required this.numberPlate,
    required this.licenseNumber,
    this.successMode = VerifySuccessMode.driverApproval,
    this.rentalPricePerDay = 0.0,
  });

  @override
  State<VerificationPendingScreen> createState() =>
      _VerificationPendingScreenState();
}

class _VerificationPendingScreenState
    extends State<VerificationPendingScreen> {
  int _step = 0;
  int _secondsLeft = 15;
  bool _isDone = false;

  static const List<String> _checkSteps = [
    "Submitting your documents...",
    "Verifying personal information...",
    "Checking vehicle details...",
    "Reviewing license & billbook...",
    "Finalizing your account...",
  ];

  @override
  void initState() {
    super.initState();
    _runChecks();
  }

  Future<void> _runChecks() async {
    for (int i = 0; i < _checkSteps.length; i++) {
      if (!mounted) return;
      setState(() => _step = i);

      for (int s = 3; s > 0; s--) {
        if (!mounted) return;
        setState(() =>
            _secondsLeft = ((_checkSteps.length - i - 1) * 3) + s);
        await Future.delayed(const Duration(seconds: 1));
      }
    }

    if (!mounted) return;
    setState(() {
      _isDone = true;
      _secondsLeft = 0;
    });

    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => VerifySuccessScreen(
          mode: widget.successMode,
          title: widget.successMode == VerifySuccessMode.carRentalApproval
              ? "Listing Approved!"
              : "You're Approved!",
          subtitle: widget.successMode == VerifySuccessMode.carRentalApproval
              ? "Welcome, ${widget.firstName}! Your car is now listed."
              : "Welcome aboard, ${widget.firstName}! Your account is ready.",
          firstName: widget.firstName,
          lastName: widget.lastName,
          vehicleModel: widget.vehicleModel,
          numberPlate: widget.numberPlate,
          rentalPricePerDay: widget.rentalPricePerDay,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),

              // ── Animated icon ─────────────────────────────────────────
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _isDone
                    ? Container(
                        key: const ValueKey('done'),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified_rounded,
                          color: AppColors.success,
                          size: 64,
                        ),
                      )
                    : Container(
                        key: const ValueKey('loading'),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.brandBlue.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(
                            color: AppColors.brandBlue,
                            strokeWidth: 3,
                          ),
                        ),
                      ),
              ),

              const SizedBox(height: 28),

              // ── Title ─────────────────────────────────────────────────
              Text(
                _isDone ? "All Checks Passed!" : "Verifying Your Account",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                _isDone
                    ? "Redirecting you now..."
                    : "Please wait while we review your documents.",
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 36),

              // ── Check steps ───────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: List.generate(_checkSteps.length, (index) {
                    final bool isDone = index < _step || _isDone;
                    final bool isActive = index == _step && !_isDone;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: isDone
                                  ? AppColors.success.withOpacity(0.15)
                                  : isActive
                                      ? AppColors.brandBlue.withOpacity(0.1)
                                      : Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: isDone
                                  ? const Icon(Icons.check_rounded,
                                      size: 16, color: AppColors.success)
                                  : isActive
                                      ? const SizedBox(
                                          width: 14,
                                          height: 14,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.brandBlue,
                                          ),
                                        )
                                      : Icon(Icons.circle,
                                          size: 8,
                                          color: Colors.grey[400]),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              _checkSteps[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isActive
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isDone
                                    ? AppColors.textPrimary
                                    : isActive
                                        ? AppColors.brandBlue
                                        : AppColors.textSecondary,
                              ),
                            ),
                          ),
                          if (isActive)
                            Text(
                              "${_secondsLeft}s",
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.brandBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (isDone)
                            const Text(
                              "✓",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.success,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 24),

              // ── Countdown bar ─────────────────────────────────────────
              if (!_isDone) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Estimated time",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      "$_secondsLeft seconds remaining",
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.brandBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: 1 - (_secondsLeft / 15),
                    minHeight: 8,
                    backgroundColor: Colors.grey[200],
                    color: AppColors.brandBlue,
                  ),
                ),
              ],

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}