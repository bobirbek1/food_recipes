import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_recipes/pages/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    _startTimer(context);
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fastfood,
              size: 64,
              color: Colors.black,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Food recipes",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _startTimer(BuildContext context) {
    Timer(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const HomePage();
        },
      ),);
    });
  }
}
