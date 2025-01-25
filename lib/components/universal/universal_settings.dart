import 'package:flutter/material.dart';


class ThemeModel with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      useMaterial3: true,
      cardTheme: CardTheme(
        color: Colors.purple.shade50,
        elevation: 8,
      ),
      textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black, fontSize: 14)
      ),
      inputDecorationTheme:  InputDecorationTheme(
        fillColor: Colors.grey.shade200,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.transparent),
        ),

      )

    // accentColor: Colors.blueAccent,
    // Define additional light theme properties here
  );
  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.green.shade900,
    primaryColor: Colors.grey[900],
    useMaterial3: true,

    textTheme: TextTheme(
        bodyMedium: TextStyle(color: Colors.white, fontSize: 14)
    ),
    // accentColor: Colors.blueAccent,
    // Define additional dark theme properties here
  );

}
