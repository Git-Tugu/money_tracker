import 'dart:async';
import 'package:flutter/material.dart';

class HelloSplash extends StatefulWidget {
  final Widget nextScreen;
  const HelloSplash({super.key, required this.nextScreen});

  @override
  State<HelloSplash> createState() => _HelloSplashState();
}

class _HelloSplashState extends State<HelloSplash> {
  @override
  void initState() {
    super.initState();
    // Navigate to nextScreen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => widget.nextScreen),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => 
              const Icon(Icons.broken_image, size: 100, color: Colors.grey),
        ),
      ),
    );
  }
}
