import 'package:flutter/material.dart';
// - Import the next screen in the delivery flow
import 'ongoing_trip_screen.dart'; 

class DeliveryRouteScreen extends StatelessWidget {
  const DeliveryRouteScreen({super.key});

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
      body: Column(
        children: [
          // Map View Area
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/map_placeholder.png'), 
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "6.2 km",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Customer Details Section
          Container(
            color: Colors.grey[300],
            padding: const EdgeInsets.all(20),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  // - Using Lisa Blackpink avatar
                  backgroundImage: AssetImage('assets/lisa_avatar.png'), 
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Lisa Blackpink", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("2 Packages To NADI", style: TextStyle(color: Colors.black54, fontSize: 12)),
                    ],
                  ),
                ),
                Text("Rm 5", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          // Action Button - Fixed to navigate to Ongoing Trip
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004687), // Uni-RIDE Blue
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // - Navigate to Ongoing Trip detail screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OngoingTripScreen(),
                    ),
                  );
                },
                child: const Text(
                  "On My Way !",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          
          const Spacer(),
          
          // Bottom Navigation
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[300]!))),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavIcon(Icons.home, "Home", true),
          _NavIcon(Icons.layers, "History", false),
          _NavIcon(Icons.person_outline, "Account", false),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  const _NavIcon(this.icon, this.label, this.isActive);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? Colors.black : Colors.grey),
        Text(label, style: TextStyle(color: isActive ? Colors.black : Colors.grey, fontSize: 10)),
      ],
    );
  }
}