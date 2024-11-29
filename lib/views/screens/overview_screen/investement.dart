import 'package:expensy/views/themes/colors.dart';
import 'package:flutter/material.dart';

class Investements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monthly Budget"),
        backgroundColor: DarkMode.neutralColor,
      ),
      body: Center(
        child: Text(
          "This is the investements screen.",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      backgroundColor: DarkMode.backgroundColor,
    );
  }
}
