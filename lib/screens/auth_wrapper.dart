// lib/screens/auth_wrapper.dart
import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'signin_screen.dart';
import 'signup_screen.dart';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [
          RegisterScreen(
            onNavigate: () {
              pageController.animateToPage(1, 
                duration: Duration(milliseconds: 300), 
                curve: Curves.easeInOut);
            },
          ),
          SignInScreen(
            onNavigateRegister: () {
              pageController.animateToPage(0, 
                duration: Duration(milliseconds: 300), 
                curve: Curves.easeInOut);
            },
            onNavigateSignUp: () {
              pageController.animateToPage(2, 
                duration: Duration(milliseconds: 300), 
                curve: Curves.easeInOut);
            },
          ),
          SignUpScreen(
            onNavigate: () {
              pageController.animateToPage(1, 
                duration: Duration(milliseconds: 300), 
                curve: Curves.easeInOut);
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavDot(0),
            SizedBox(width: 8),
            _buildNavDot(1),
            SizedBox(width: 8),
            _buildNavDot(2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavDot(int index) {
    return GestureDetector(
      onTap: () {
        pageController.animateToPage(index, 
          duration: Duration(milliseconds: 300), 
          curve: Curves.easeInOut);
      },
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: currentIndex == index 
            ? Colors.purple 
            : Colors.grey.withOpacity(0.5),
        ),
      ),
    );
  }
}