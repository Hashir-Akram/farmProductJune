import 'package:faramproduct/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

enum ThemeModeOption { system, light, dark }

class ThemeProvider extends ChangeNotifier {
  ThemeModeOption _currentThemeMode = ThemeModeOption.system;

  ThemeModeOption get currentThemeMode => _currentThemeMode;

  void setThemeMode(ThemeModeOption mode) {
    _currentThemeMode = mode;
    notifyListeners();
  }
}

final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue, // Customize your light mode theme properties
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(Colors.black26),
      checkColor: MaterialStateProperty.all(Colors.black26),
    ));

final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue, // Customize your dark mode theme properties
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(Colors.black26),
      checkColor: MaterialStateProperty.all(Colors.black26),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.currentThemeMode == ThemeModeOption.system
          ? ThemeMode.system
          : themeProvider.currentThemeMode == ThemeModeOption.light
          ? ThemeMode.light
          : ThemeMode.dark,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const Splash(),
    );
  }
}
