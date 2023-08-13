import 'package:faramproduct/profile.dart';
import 'package:faramproduct/settings.dart';
import 'package:faramproduct/signIn.dart';
import 'package:faramproduct/splash.dart';
import 'package:flutter/material.dart';

import 'groceryList.dart';

Widget appDrawer(BuildContext context){
  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(child: Image(image: AssetImage('assets/images/logo.png')),
            decoration: BoxDecoration(
              color: Colors.blue,
            )
        ),

        ListTile(
          leading: Icon(Icons.present_to_all,color: Colors.black),
          title: Text("Splash"),
          onTap: (){
            print("splash");
            Navigator.push(context, MaterialPageRoute(builder: (context) => Splash()));
          },
        ),

        ListTile(
          leading: Icon(Icons.account_circle_outlined,color: Colors.black),
          title: Text("Profile"),
          onTap: (){
            print("Profile");
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
          },
        ),
        ListTile(
          leading: Icon(Icons.local_grocery_store_outlined,color: Colors.black),
          title: Text("Grocery List"),
          onTap: (){
            print("Profile");
            Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryList()));
          },
        ),
        ListTile(
          leading: Icon(Icons.settings,color: Colors.black),
          title: Text("Settings"),
          onTap: (){
            print("Setting");
            Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
          },
        ),
        ListTile(
          leading: Icon(Icons.info_outline_rounded,color: Colors.black),
          title: Text("About"),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => About()));
          },
        ),
        ListTile(
          leading: Icon(Icons.logout_outlined,color: Colors.black),
          title: Text("LogOut"),
          onTap: (){
            print("Profile");
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return SignIn();
              },
            ), (route) => false);
          },
        ),
      ],
    ),
  );
}