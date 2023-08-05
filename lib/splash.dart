import 'package:faramproduct/groceryList.dart';
import 'package:faramproduct/signIn.dart';
import 'package:flutter/material.dart';

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
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash.png"),
              fit: BoxFit.cover,
            ),
          ),
          child:Container(),
        ),
      ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              // backgroundColor: customTheme.estatePrimary,
              child: Icon(
                Icons.arrow_circle_right_outlined,
              ),
              onPressed: () async {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return SignIn();
                      },
                    ), (route) => false);
                // Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryList()));
              },
            ),
          ),
        ));

  }
}
