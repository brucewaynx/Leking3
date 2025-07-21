import 'package:flutter/material.dart';
import 'profile_screen.dart'; // <-- Make sure this matches your filename

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modern Profile',
      theme: ThemeData.dark(),
      home: const ProfileScreen(),
    );
  }
}
