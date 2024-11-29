import 'package:flutter/material.dart';

// class LightMode {
//   static const Color primaryColor = Color(value);
//   static const Color accentColor = Colors.orange;
//   static const Color backgroundColor = Colors.white;
//   static const Color buttonColor = Colors.green;
//   // Add more colors as needed
// }

class DarkMode {
  static const Color primaryColor = Color.fromRGBO(35, 44, 51, 1);
  static const Color backgroundColor = Color(0xFF1F2933);
  static const Color neutralColor = Color.fromRGBO(16, 29, 39, 1);
  static const Color buttonColor = Color.fromRGBO(30, 66, 250, 1);
  static const Color iconBackground = Color.fromRGBO(62, 76, 89, 1);
  static const Color iconBackground2 = Color.fromRGBO(85, 112, 250, 1);

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [
      Color.fromRGBO(0, 29, 252, 1),
      Color.fromRGBO(43, 176, 237, 1),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  // Add more colors as needed
}
