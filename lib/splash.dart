// ignore_for_file: use_build_context_synchronously

import 'package:faramproduct/groceryList.dart';
import 'package:faramproduct/signIn.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/splash.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              // backgroundColor: customTheme.estatePrimary,
              child: const Icon(
                Icons.arrow_circle_right_outlined,
              ),
              onPressed: () async {
                _handleButtonClick();
              },
            ),
          ),
        ));
  }

  void _handleButtonClick() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSignedIn = prefs.getBool('isSignedIn') ?? false;

    if (isSignedIn) {
      // User is signed in, redirect to GroceryList
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GroceryList()),
      );
    } else {
      // User is not signed in or logged out, redirect to SignIn
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignIn()),
      );
    }
  }
}
