import 'package:flutter/material.dart';
import 'constants.dart';
import 'car_rental_listing_screen.dart';
import 'account_profile_screen.dart';

class CarRentalDashboard extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String vehicleModel;
  final String numberPlate;
  final double rentalPricePerDay;

  const CarRentalDashboard({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.vehicleModel,
    required this.numberPlate,
    required this.rentalPricePerDay,
  });

  @override
  State<CarRentalDashboard> createState() => _CarRentalDashboardState();
}

class _CarRentalDashboardState extends State<CarRentalDashboard> {
  int _currentIndex = 0;
  bool _isAvailable = true;
  final double _totalEarnings = 0.0;
  final int _totalRentals = 0;

  // Simulated active booking
  static const _mockBooking = _BookingInfo(
    renterName: "Ahmad Fariz",
    startDate: "22 Mar 2026",
    endDate: "24 Mar 2026",
    totalDays: 2,
    status: "Active",
  );

  String get _firstName => widget.firstName;

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AccountProfileScreen()),
      ).then((_) => setState(() => _currentIndex = 0));
    }
  }

  void _toggleAvailability() {
    setState(() => _isAvailable = !_isAvailable);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isAvailable
            ? "Your car is now available for rent"
            : "Your car is now unavailable"),
        backgroundColor:
            _isAvailable ? AppColors.success : Colors.grey,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.textPrimary,
        unselectedItemColor: AppColors.textSecondary,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Account"),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, $_firstName!",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          widget.vehicleModel,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.cyan,
                      radius: 22,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // ── Availability toggle ──────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: _toggleAvailability,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: _isAvailable
                          ? AppColors.success
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isAvailable
                              ? Icons.check_circle_outline
                              : Icons.cancel_outlined,
                          color: _isAvailable
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _isAvailable
                              ? "Car Available for Rent"
                              : "Mark as Available",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _isAvailable
                                ? Colors.white
                                : Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Stats cards ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        label: "Total Earnings",
                        value:
                            "RM ${_totalEarnings.toStringAsFixed(2)}",
                        icon: Icons.account_balance_wallet_outlined,
                        color: AppColors.brandBlue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        label: "Total Rentals",
                        value: "$_totalRentals",
                        icon: Icons.directions_car_outlined,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Vehicle card ─────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.inputFill,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.brandBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.directions_car,
                          color: AppColors.brandBlue,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.vehicleModel,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              widget.numberPlate,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "RM ${widget.rentalPricePerDay.toStringAsFixed(0)}/day",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.brandBlue,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: _isAvailable
                                  ? AppColors.success.withOpacity(0.1)
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _isAvailable
                                  ? "Available"
                                  : "Unavailable",
                              style: TextStyle(
                                fontSize: 11,
                                color: _isAvailable
                                    ? AppColors.success
                                    : Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Active booking ────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Active Booking",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: AppColors.brandBlue, width: 1.5),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12, blurRadius: 6)
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.cyanAccent,
                                    child: Icon(Icons.person,
                                        size: 18, color: Colors.white),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    _mockBooking.renterName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.success
                                      .withOpacity(0.1),
                                  borderRadius:
                                      BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _mockBooking.status,
                                  style: const TextStyle(
                                    color: AppColors.success,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              _BookingDetail(
                                label: "From",
                                value: _mockBooking.startDate,
                              ),
                              _BookingDetail(
                                label: "To",
                                value: _mockBooking.endDate,
                              ),
                              _BookingDetail(
                                label: "Days",
                                value:
                                    "${_mockBooking.totalDays} days",
                              ),
                              _BookingDetail(
                                label: "Earn",
                                value:
                                    "RM ${(widget.rentalPricePerDay * _mockBooking.totalDays).toStringAsFixed(0)}",
                                valueColor: AppColors.brandBlue,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── View listings button ──────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CarRentalListingScreen(
                          vehicleModel: widget.vehicleModel,
                          numberPlate: widget.numberPlate,
                          rentalPricePerDay: widget.rentalPricePerDay,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Browse Available Cars",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Stat card ─────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Booking detail ────────────────────────────────────────────────────────────
class _BookingDetail extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _BookingDetail({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

// ── Data models ───────────────────────────────────────────────────────────────
class _BookingInfo {
  final String renterName;
  final String startDate;
  final String endDate;
  final int totalDays;
  final String status;

  const _BookingInfo({
    required this.renterName,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.status,
  });
}