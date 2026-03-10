import 'package:flutter/material.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu),
                  const Text("Welcome, Alif!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const CircleAvatar(backgroundColor: Colors.cyan, child: Icon(Icons.person, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Your current locations", style: TextStyle(color: Colors.grey, fontSize: 12)),
              const Row(
                children: [
                  Icon(Icons.location_on, color: Colors.deepPurple, size: 18),
                  Text(" Bota, Perak", style: TextStyle(fontWeight: FontWeight.bold)),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
              const SizedBox(height: 20),
              // Placeholder for Map
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(image: AssetImage('assets/map_placeholder.png'), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 20),
              _buildActionTile(Icons.location_on, "Where do you wanna go?", color: Colors.red),
              _buildActionTile(Icons.star, "Choose a saved place"),
              _buildActionTile(Icons.map, "Set destination on map"),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: const Color(0xFF004687), borderRadius: BorderRadius.circular(15)),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("New on the town", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("on the market, beat the Market", style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account'),
        ],
        selectedItemColor: Colors.black,
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, {Color color = Colors.black}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      trailing: const Icon(Icons.chevron_right, size: 18),
    );
  }
}