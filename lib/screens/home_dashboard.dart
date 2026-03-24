import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'route_selection_screen.dart';
import 'active_orders_screen.dart';
import 'account_profile_screen.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  static const LatLng _passengerLocation = LatLng(4.388965, 100.965852);

  static const List<String> _seriIskandarPlaces = [
    "McDonald's Seri Iskandar",
    "D Mall Seri Iskandar",
    "Petronas UTP",
    "Tesco Seri Iskandar",
    "KFC Seri Iskandar",
    "Domino's Pizza Seri Iskandar",
    "UTP Chancellor Complex",
  ];

  String _userName = "Passenger";
  String _placeOfTheDay = "";
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    final shuffled = List<String>.from(_seriIskandarPlaces)..shuffle();
    _placeOfTheDay = shuffled.first;
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() => _userName = prefs.getString("name") ?? "Passenger");
  }

  void _goToRouteSelection() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RouteSelectionScreen()),
    );
  }

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ActiveOrdersScreen()),
      ).then((_) => setState(() => _currentIndex = 0));
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AccountProfileScreen()),
      ).then((_) => setState(() => _currentIndex = 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double mapHeight = MediaQuery.of(context).size.height * 0.30;

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
              // ── Header ────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.menu, size: 28),
                    Text(
                      "Welcome, $_userName!",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.cyan,
                      radius: 20,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // ── Location label ────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    const Icon(Icons.location_on,
                        color: AppColors.brandBlue, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      "Seri Iskandar, Perak",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ── Map ───────────────────────────────────────────────────
              Container(
                height: mapHeight,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FlutterMap(
                    options: const MapOptions(
                      initialCenter: _passengerLocation,
                      initialZoom: 14,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: 'com.example.uniride',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _passengerLocation,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Action tiles ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _ActionTile(
                      icon: Icons.search,
                      title: "Where do you wanna go?",
                      isSearch: true,
                      onTap: _goToRouteSelection,
                    ),
                    const SizedBox(height: 12),
                    _ActionTile(
                      icon: Icons.star,
                      title: "Choose a saved place",
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Saved places feature coming soon"),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _ActionTile(
                      icon: Icons.map,
                      title: "Set destination on map",
                      onTap: _goToRouteSelection,
                    ),

                    const SizedBox(height: 24),

                    // ── New on the town banner ────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.brandBlue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "New on the town",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "on the market, Beat the Market",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _placeOfTheDay,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Reusable action tile ──────────────────────────────────────────────────────
class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSearch;
  final VoidCallback? onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    this.isSearch = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSearch ? AppColors.inputFill : AppColors.background,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: isSearch ? AppColors.brandBlue : AppColors.textPrimary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSearch ? AppColors.textSecondary : AppColors.textPrimary,
            fontSize: 15,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          size: 20,
          color: Colors.grey,
        ),
      ),
    );
  }
}