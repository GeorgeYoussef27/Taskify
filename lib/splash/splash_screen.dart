import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:taskify/ui/home/home_screen.dart';
import 'package:taskify/ui/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      navigateToInitialScreen();
    });
  }

  navigateToInitialScreen() {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: height * 0.3,
              width: width * 0.6,
              fit: BoxFit.fill,
            ),
            Text("Taskify", style: Theme.of(context).textTheme.titleSmall)
          ],
        )
            .animate()
            .scale(curve: Curves.fastOutSlowIn, duration: Duration(seconds: 2)),
      ),
    );
  }
}
