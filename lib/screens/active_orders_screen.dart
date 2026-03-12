import 'package:flutter/material.dart';
// - Import the delivery route screen
import 'delivery_route_screen.dart'; 

class ActiveOrdersScreen extends StatelessWidget {
  const ActiveOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data based on your design
    final List<Map<String, String>> orders = [
      {"name": "Fatma", "route": "V4 TO PARCEL HUB", "price": "Rm 5"},
      {"name": "Ayu", "route": "V6C TO V1A", "price": "Rm 5"},
      {"name": "Sheldon", "route": "V7 CAFE TO V3C", "price": "Rm 6"},
      {"name": "Lisa Blackpink", "route": "V2C TO NADI", "price": "Rm 5"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Active Orders",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: orders.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final order = orders[index];
                // Highlight specific item as per design
                bool isHighlighted = order['name'] == "Sheldon";

                // - InkWell added to make items clickable
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DeliveryRouteScreen(),
                      ),
                    );
                  },
                  child: Container(
                    color: isHighlighted ? Colors.grey[300] : Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blueAccent,
                          child: Icon(Icons.person, color: Colors.white), 
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(order['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(order['route']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ),
                        Text(order['price']!, style: const TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home, "Home", true),
          _navItem(Icons.layers, "History", false),
          _navItem(Icons.person_outline, "Account", false),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? Colors.black : Colors.grey),
        Text(label, style: TextStyle(color: isActive ? Colors.black : Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}