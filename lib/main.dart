import 'package:flutter/material.dart';
import 'screens/join_screen.dart' show JoinScreen;
// This links your first screen

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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const JoinScreen(), // This launches your design
    );
  }
}