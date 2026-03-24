import 'package:flutter/material.dart';

class CourierSelectionScreen extends StatelessWidget {
  const CourierSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          // Map View Area
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.blueGrey[100], // Placeholder for Google Maps
                  child: Image.asset(
                    'assets/map_placeholder.png', 
                    fit: BoxFit.cover,
                  ),
                ),
                // Map Overlay Elements
                Positioned(
                  top: 60,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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

          // Courier Selection Details
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  // Courier List
                  _buildCourierTile("Aniq", "16:30 - 3 min away", "Rm 5", Icons.person),
                  const Divider(),
                  _buildCourierTile("Fatma", "16:00 - 10 min away", "Rm 5", Icons.person_3),
                  const Spacer(),

                  // Payment Method Selector
                  ListTile(
                    leading: const Icon(Icons.credit_card, color: Colors.grey),
                    title: const Text("Add Payment method"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF004687), // Uni-RIDE Blue
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {},
                          child: const Text("Choose Courier", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.car_rental, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }

  Widget _buildCourierTile(String name, String details, String price, IconData icon) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[50],
        child: Icon(icon, color: Colors.blue[900]),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(details, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}