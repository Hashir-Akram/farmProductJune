import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';
import 'main.dart';
import 'notification.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  NotificationUtility notificationUtility = NotificationUtility();
  bool darkMode = false;
  bool showCustomSoundNotification = false;
  String selectedLanguage = "";
  bool showScheduledNotification = false;

  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'hi', 'name': 'Hindi'},
  ];

  @override
  void initState() {
    super.initState();
    _initializeNotificationSettings();
  }

  Future<void> _initializeNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      darkMode = prefs.getBool('darkMode') ??
          false; // Load dark mode setting, default to false if not found
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
        backgroundColor: Colors.blue,
      ),
      drawer: appDrawer(context),
      body: Center(
          child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Container(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              "Preferences".toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                  fontSize: 20),
            ),
          ),
          Container(
              padding:
                  const EdgeInsets.only(top: 16, bottom: 4, left: 5, right: 5),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    const Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Show Scheduled Notification",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Text(
                              "Enable/Disable Mobile Notification",
                              style: TextStyle(),
                            ))
                      ],
                    )),
                    const VerticalDivider(
                      color: Colors.grey,
                    ),
                    Switch(
                        value: showScheduledNotification,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            showScheduledNotification = value;
                          });
                          if (value) {
                            notificationUtility
                                .scheduleNotificationAfter5Seconds();
                          }
                        })
                  ],
                ),
              )),
          Container(
              padding:
                  const EdgeInsets.only(top: 16, bottom: 4, left: 5, right: 5),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    const Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Show Custom Notification",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Text(
                              "Enable/Disable Custom Notification",
                              style: TextStyle(),
                            ))
                      ],
                    )),
                    const VerticalDivider(
                      color: Colors.grey,
                    ),
                    Switch(
                        value: showCustomSoundNotification,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            showCustomSoundNotification = value;
                          });
                          if (value) {
                            notificationUtility
                                .showNotificationCustomSound();
                          }
                        })
                  ],
                ),
              )),
          Container(
              padding:
                  const EdgeInsets.only(top: 16, bottom: 4, left: 5, right: 5),
              child: IntrinsicHeight(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Dark Mode",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Text("Save battery Power"))
                      ],
                    )),
                    const VerticalDivider(
                      color: Colors.grey,
                    ),
                    Switch(
                        value: darkMode,
                        activeColor: Colors.blue,
                        onChanged:  (value) async {
                          setState(() {
                            darkMode = value;
                          });
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('darkMode', value); // Save dark mode setting
                          darkMode
                              ? themeProvider.setThemeMode(ThemeModeOption.dark)
                              : themeProvider.setThemeMode(ThemeModeOption.light);
                        },
                    )
                  ],
                ),
              )),
          Container(
              padding:
                  const EdgeInsets.only(top: 16, bottom: 4, left: 5, right: 5),
              child: IntrinsicHeight(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Language",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Text("Chose Your language "))
                      ],
                    )),
                    Expanded(
                      child: DropdownButtonFormField(
                          items: languages.map((languages) {
                            return DropdownMenuItem<String>(
                              value: languages["code"],
                              child: Text(
                                  '${languages["code"]} (${languages["name"]})'),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedLanguage = value!;
                            });
                          },
                          borderRadius: BorderRadius.circular(8),
                          hint: const Text("Select Language")),
                    )
                  ],
                ),
              )),
        ],
      )),
    );
  }
}
