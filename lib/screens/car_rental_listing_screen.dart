import 'package:flutter/material.dart';
import 'constants.dart';
import 'car_rental_booking_screen.dart';

class CarRentalListingScreen extends StatefulWidget {
  final String vehicleModel;
  final String numberPlate;
  final double rentalPricePerDay;

  const CarRentalListingScreen({
    super.key,
    required this.vehicleModel,
    required this.numberPlate,
    required this.rentalPricePerDay,
  });

  @override
  State<CarRentalListingScreen> createState() =>
      _CarRentalListingScreenState();
}

class _CarRentalListingScreenState
    extends State<CarRentalListingScreen> {
  String _selectedFilter = "All";

  static const List<String> _filters = [
    "All",
    "Car",
    "SUV",
    "Van",
    "MPV",
    "Pickup Truck",
  ];

  List<CarListing> get _listings => [
        CarListing(
          model: widget.vehicleModel,
          plate: widget.numberPlate,
          category: "Car",
          pricePerDay: widget.rentalPricePerDay,
          rating: 4.8,
          isAvailable: true,
          ownerName: "Azri",
        ),
        const CarListing(
          model: "Toyota Hilux",
          plate: "BCD 5678",
          category: "Pickup Truck",
          pricePerDay: 200,
          rating: 4.5,
          isAvailable: true,
          ownerName: "Hafiz",
        ),
        const CarListing(
          model: "Honda CRV",
          plate: "EFG 9012",
          category: "SUV",
          pricePerDay: 180,
          rating: 4.9,
          isAvailable: false,
          ownerName: "Syafiq",
        ),
        const CarListing(
          model: "Proton Exora",
          plate: "HIJ 3456",
          category: "MPV",
          pricePerDay: 120,
          rating: 4.3,
          isAvailable: true,
          ownerName: "Aiman",
        ),
      ];

  List<CarListing> get _filteredListings => _selectedFilter == "All"
      ? _listings
      : _listings.where((c) => c.category == _selectedFilter).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Available Cars",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // ── Filter chips ───────────────────────────────────────────
          SizedBox(
            height: 50,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final bool selected = _selectedFilter == filter;
                return GestureDetector(
                  onTap: () =>
                      setState(() => _selectedFilter = filter),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.brandBlue
                          : AppColors.inputFill,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: selected
                            ? Colors.white
                            : AppColors.textPrimary,
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // ── Car list ───────────────────────────────────────────────
          Expanded(
            child: _filteredListings.isEmpty
                ? const Center(
                    child: Text(
                      "No cars available in this category",
                      style:
                          TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredListings.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final car = _filteredListings[index];
                      return CarCard(
                        car: car,
                        onTap: car.isAvailable
                            ? () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        CarRentalBookingScreen(
                                      car: car,
                                    ),
                                  ),
                                )
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Car card widget ───────────────────────────────────────────────────────────
class CarCard extends StatelessWidget {
  final CarListing car;
  final VoidCallback? onTap;

  const CarCard({super.key, required this.car, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: car.isAvailable ? 1.0 : 0.5,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 6)
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Car image placeholder ────────────────────────────
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.directions_car,
                  size: 50,
                  color: AppColors.brandBlue,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car.model,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          "${car.category} · ${car.plate}",
                          style: const TextStyle(
                            fontSize: 12,
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
                        "RM ${car.pricePerDay.toStringAsFixed(0)}/day",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.brandBlue,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              size: 12, color: AppColors.gold),
                          const SizedBox(width: 2),
                          Text(
                            car.rating.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Owner: ${car.ownerName}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: car.isAvailable
                          ? AppColors.success.withOpacity(0.1)
                          : AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      car.isAvailable ? "Available" : "Rented",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: car.isAvailable
                            ? AppColors.success
                            : AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Public CarListing model ───────────────────────────────────────────────────
class CarListing {
  final String model;
  final String plate;
  final String category;
  final double pricePerDay;
  final double rating;
  final bool isAvailable;
  final String ownerName;

  const CarListing({
    required this.model,
    required this.plate,
    required this.category,
    required this.pricePerDay,
    required this.rating,
    required this.isAvailable,
    required this.ownerName,
  });
}