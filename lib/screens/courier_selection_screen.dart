import 'package:flutter/material.dart';
import 'shipment_tracking_screen.dart'; // Ensure this file is created

class CourierSelectionScreen extends StatefulWidget {
  const CourierSelectionScreen({super.key});

  @override
  State<CourierSelectionScreen> createState() => _CourierSelectionScreenState();
}

class _CourierSelectionScreenState extends State<CourierSelectionScreen> {
  // Track which courier is currently selected
  int _selectedCourierIndex = 0;

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
                  color: Colors.grey[300],
                  child: Image.network(
                    'https://storage.googleapis.com/flutter-static-artifacts/figma-images/map_placeholder.png', 
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(child: Text("Map View")),
                  ),
                ),
                // 6.2 km Distance Tag
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

          // Courier Details Section
          Expanded(
            flex: 6,
            child: Column(
              children: [
                _buildCourierTile(0, "Aniq", "16:30 - 3 min away", "Rm 5"),
                _buildCourierTile(1, "Fatma", "16:00 - 10 min away", "Rm 5"),
                
                const Spacer(),

                // Payment Method Selector
                const ListTile(
                  leading: Icon(Icons.credit_card, color: Colors.grey),
                  title: Text("Add Payment method", style: TextStyle(fontSize: 14)),
                  trailing: Icon(Icons.chevron_right),
                ),

                // Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF004687), // Uni-RIDE Blue
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            // Navigates to the Shipment Tracking Screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ShipmentTrackingScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Choose Courier", 
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Schedule/Vehicle Icon
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
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }

  Widget _buildCourierTile(int index, String name, String details, String price) {
    bool isSelected = _selectedCourierIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedCourierIndex = index),
      child: Container(
        color: isSelected ? Colors.grey[200] : Colors.transparent, // Highlight logic
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[50],
            child: Icon(index == 0 ? Icons.person : Icons.person_3, color: const Color(0xFF004687)),
          ),
          title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(details, style: const TextStyle(fontSize: 12)),
          trailing: Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}