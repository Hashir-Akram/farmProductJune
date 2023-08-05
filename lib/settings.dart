import 'package:faramproduct/groceryList.dart';
import 'package:faramproduct/splash.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings"),
        backgroundColor: Colors.blue,
        actions: [
          GestureDetector(child: Icon(Icons.notifications_active_outlined),onTap: (){
            print("Bell Pressed");
          },)
        ],
      ),
      drawer:appDrawer(context),
      body: Center(child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Container(
            child: Text("Preferences".toUpperCase(),style: TextStyle(
              color: Colors.black87,fontWeight: FontWeight.w500,letterSpacing: 0.3,
            ),),
          ),
          Container(
            padding: EdgeInsets.only(top: 16, bottom: 4),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Dark Mode",
                            ),
                        Container(
                            margin: EdgeInsets.only(top: 4),
                            child: Text("Save battery Power",
                            )),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.black38,
                    thickness: 1.2,
                  ),
                  Switch(
                    onChanged: (bool value) async {
                      setState(() {
                        // _showNotification = value;
                      });
                    },
                    // value: _showNotification,
                    activeColor: Colors.blue, value: true,
                  )
                ],
              ),
            ),
          ),

        ],
      )),
    );
  }
}