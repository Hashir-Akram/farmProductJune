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
  bool darkMode = false;
  bool showNotification = false;
  String selectedlanguages = "";


  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'hi', 'name': 'Hindi'},
    // Add more languages as needed
  ];


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
              color: Colors.black87,fontWeight: FontWeight.w500,letterSpacing: 0.3,fontSize: 20
            ),),
          ),
          Container(
            padding: EdgeInsets.only(top: 16, bottom: 4,left: 5,right: 5),
            child: IntrinsicHeight(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Show Notification",style: TextStyle(
                        fontWeight: FontWeight.w600,fontSize: 16
                      ),),
                      Padding(padding: EdgeInsets.fromLTRB(0, 5,0, 0),child: Text("Enable/Disable Mobile Notification",style: TextStyle(),))
                    ],
                  )),
                  VerticalDivider(color: Colors.grey,),
                  Switch(value: showNotification,activeColor: Colors.blue, onChanged: (value){
                    setState(() {
                      showNotification = value;
                    });

                  })
                ],
              ),
            )
          ),


          Container(
              padding: EdgeInsets.only(top: 16, bottom: 4,left: 5,right: 5),
              child: IntrinsicHeight(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Dark Mode",style: TextStyle(
                            fontWeight: FontWeight.w600,fontSize: 16
                        )),
                        Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text("Save battery Power"))
                      ],
                    )),
                    VerticalDivider(color: Colors.grey,),
                    Switch(value: darkMode,activeColor: Colors.blue, onChanged: (value){
                      setState(() {
                        darkMode = value;
                      });

                    })
                  ],
                ),
              )
          ),


          Container(
              padding: EdgeInsets.only(top: 16, bottom: 4,left: 5,right: 5),
              child: IntrinsicHeight(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Language",style: TextStyle(
                            fontWeight: FontWeight.w600,fontSize: 16
                        )),
                        Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0),child: Text("Chose Your language "))
                      ],
                    )),
                    Expanded(
                      child: DropdownButtonFormField(items: languages.map((languages) {
                        return DropdownMenuItem<String>(
                          value: languages["code"],
                          child: Text(
                              '${languages["code"]} (${languages["name"]})'),
                        );
                      }).toList(), onChanged: (value){
                        setState(() {
                          selectedlanguages = value!;
                        });
          },
                      borderRadius: BorderRadius.circular(8),hint: Text("Select Language")),
                    )
                  ],
                ),
              )
          ),

        ],
      )),
    );
  }
}