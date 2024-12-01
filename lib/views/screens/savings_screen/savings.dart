import 'package:expensy/views/screens/overview_screen/overview.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/bottom_navigation_bar.dart';
import 'package:expensy/views/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';

class Savings extends StatefulWidget {
  @override
  State<Savings> createState() => _SavingsState();
}

class _SavingsState extends State<Savings> {
  int _selectedIndex = 1; // Set to 1 since this is the Savings screen.

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the respective screen
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Overview()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Savings()), // Current screen
      );
    } else if (index == 2) {
      // Uncomment and add the Notification screen when available
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (_) => const NotificationScreen()),
      // );
    } else if (index == 3) {
      // Uncomment and add the Settings screen when available
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (_) => const SettingsScreen()),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(
        title: "Savings",
        titleAlignment: MainAxisAlignment.center,
        showImage: false,
        showBackButton: true,
        backgroundColor: DarkMode.backgroundColor,
      ),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () => {print("This is the floating button")},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      backgroundColor: DarkMode.primaryColor,
      body: Center(
        child: Text(
          "This is the Savings screen.",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
