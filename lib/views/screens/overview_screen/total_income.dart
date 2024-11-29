import 'package:expensy/views/themes/colors.dart';
import 'package:flutter/material.dart';

class TotalIncome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Salary"),
        backgroundColor: DarkMode.neutralColor,
      ),
      body: Center(
        child: Text(
          "This is the Total Income screen.",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      backgroundColor: DarkMode.backgroundColor,
    );
  }
}
