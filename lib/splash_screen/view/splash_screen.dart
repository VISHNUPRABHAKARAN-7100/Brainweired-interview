import 'dart:async';
import 'package:brainwired_interview/home_screen/view/home_screen.dart';
import 'package:flutter/material.dart';

/// This screen is for a splash screen.
/// Splash screen contains logo of our
/// company. Splash screen will automatically
/// redirected to the HomeScreen.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 1),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //The variable to find the size of device.
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo.
              Image.asset(
                'asset/images/logo.png',
                height: size.height / 1.5,
                width: size.width / 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
