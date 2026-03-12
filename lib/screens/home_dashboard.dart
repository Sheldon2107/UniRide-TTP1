import 'package:flutter/material.dart';
import 'route_selection_screen.dart'; // Ensure this file exists in your lib folder

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), // Optimized for Pixel 7
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu, size: 28),
                  const Text(
                    "Welcome, Alif!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.cyan,
                    radius: 20,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Location Selector
              const Text("Your current locations", 
                style: TextStyle(color: Colors.grey, fontSize: 13)),
              const Row(
                children: [
                  Icon(Icons.location_on, color: Colors.deepPurple, size: 20),
                  SizedBox(width: 4),
                  Text("Bota, Perak", 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
              const SizedBox(height: 20),

              // Map Preview Box
              Container(
                height: screenSize.height * 0.22, 
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/map_preview.png'), 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- NAVIGATION TRIGGER SECTION ---
              _buildModernActionTile(
                context,
                Icons.location_on, 
                "Where do you wanna go?", 
                isSearch: true,
                onTap: () {
                  // Navigate to Route Selection Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RouteSelectionScreen()),
                  );
                },
              ),
              const SizedBox(height: 12),
              
              _buildModernActionTile(context, Icons.star, "Choose a saved place"),
              const SizedBox(height: 12),
              _buildModernActionTile(context, Icons.map, "Set destination on map"),
              
              const SizedBox(height: 32),

              // Promotional Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF004687), 
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New on the town",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "on the market, beat the Market",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black, // Fix for previous syntax error
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account'),
        ],
      ),
    );
  }

  // Updated Helper Widget with onTap functionality
  Widget _buildModernActionTile(BuildContext context, IconData icon, String title, {bool isSearch = false, VoidCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: isSearch ? Colors.grey[100] : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: ListTile(
        onTap: onTap, // Executes navigation when clicked
        leading: Icon(icon, color: isSearch ? Colors.red : Colors.black),
        title: Text(title, 
          style: TextStyle(
            color: isSearch ? Colors.grey[600] : Colors.black,
            fontSize: 15
          )
        ),
        trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      ),
    );
  }
}