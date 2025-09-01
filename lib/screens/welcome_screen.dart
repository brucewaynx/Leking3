import 'package:flutter/material.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 84, height: 84,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAEAFD),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.image, size: 44, color: Color(0xFF6A6CF6)),
              ),
              const SizedBox(height: 24),
              const Text(
                'GALLERIA',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: 1.2),
              ),
              const SizedBox(height: 8),
              const Text(
                'VISUAL EXCELLENCE',
                style: TextStyle(color: Colors.black54),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    // go to your current Home (Gallery)
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  },
                  child: const Text('EXPLORE GALLERY'),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Curated collections of exceptional design',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
