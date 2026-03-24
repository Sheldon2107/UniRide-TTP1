//
import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Import the Login screen
// You can remove this if unused in main

void main() {
  runApp(const UniRideApp());
}

class UniRideApp extends StatelessWidget {
  const UniRideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uni-Ride',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Set LoginScreen as the starting point
      home: const LoginScreen(), 
    );
  }
}