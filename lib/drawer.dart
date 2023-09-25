// ignore_for_file: use_build_context_synchronously

import 'package:faramproduct/about.dart';
import 'package:faramproduct/api.dart';
import 'package:faramproduct/cart.dart';
import 'package:faramproduct/favorite.dart';
import 'package:faramproduct/profile.dart';
import 'package:faramproduct/settings.dart';
import 'package:faramproduct/signIn.dart';
import 'package:faramproduct/splash.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'groceryList.dart';

Widget appDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Image(image: AssetImage('assets/images/logo.png'))),
        ListTile(
          leading: const Icon(Icons.storefront_outlined,
              color: Colors.blue),
          title: const Text("Grocery List"),
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const GroceryList()),
              (route) => false,
            );
          },
        ),
        const Divider(height: 2),
        ListTile(
          leading: const Icon(Icons.shopping_cart_outlined,
              color: Colors.blue),
          title: const Text("Cart"),
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
              (route) => false,
            );
          },
        ),
        const Divider(height: 2),
        ListTile(
          leading: const Icon(Icons.favorite_border_outlined,
              color: Colors.blue),
          title: const Text("Favorite Items"),
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const FavoritePage()),
              (route) => false,
            );
          },
        ),
        const Divider(height: 2),
        ListTile(
          leading:
              const Icon(Icons.account_circle_outlined, color: Colors.blue),
          title: const Text("Profile"),
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Profile()),
              (route) => false,
            );
          },
        ),
        const Divider(height: 2),
        ListTile(
          leading: const Icon(Icons.settings, color: Colors.blue),
          title: const Text("Settings"),
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Settings()),
              (route) => false,
            );
          },
        ),
        const Divider(height: 2),
        ListTile(
          leading: const Icon(Icons.info_outline_rounded, color: Colors.blue),
          title: const Text("About"),
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const About()),
              (route) => false,
            );
          },
        ),
        const Divider(height: 2),
        ListTile(
          leading: const Icon(Icons.api, color: Colors.blue),
          title: const Text("API"),
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const API()),
              (route) => false,
            );
          },
        ),
        const Divider(height: 2),
        ListTile(
          leading: const Icon(Icons.present_to_all, color: Colors.blue),
          title: const Text("Splash"),
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Splash()),
              (route) => false,
            );
          },
        ),
        const Divider(height: 2),
        ListTile(
          leading: const Icon(Icons.logout_outlined, color: Colors.blue),
          title: const Text("LogOut"),
          onTap: () {
            logOut(context);
          },
        ),
        const Divider(height: 2),
      ],
    ),
  );
}

// Function to log out
void logOut(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isSignedIn', false);

  // Navigate to the SignIn screen and remove all previous routes
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const SignIn()),
    (route) => false,
  );
}
