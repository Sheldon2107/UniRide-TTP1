import 'package:flutter/material.dart';
// - Import the next screen in the delivery workflow
import 'courier_delivery_picture_screen.dart';

class OngoingTripScreen extends StatelessWidget {
  const OngoingTripScreen({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Map Section
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/map_route_v2c.png'), // Specific route map
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          
          // Trip Details Section
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ongoing Trip",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 4),
                const SizedBox(height: 15),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Alif Aziz", // Customer Name
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.phone_in_talk),
                      onPressed: () {
                        // Logic for initiating a phone call to the customer
                      }, 
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Pickup Information
                const Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red),
                    SizedBox(width: 10),
                    Text("PICKUP LOCATION", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 35.0),
                  child: Text("V2C", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),

                // Drop-off Information
                const Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.green),
                    SizedBox(width: 10),
                    Text("DROPOFF LOCATION", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 35.0),
                  child: Text("NADI", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 40),

                // Action Button - Fixed to navigate to the Courier Delivery Picture Screen
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004687), // Brand Blue
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      // - Navigate to delivery confirmation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CourierDeliveryPictureScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "On My Way !",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}