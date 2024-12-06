import 'package:expensy/views/screens/overview_screen/add.dart';
import 'package:expensy/views/screens/overview_screen/overview.dart';
import 'package:expensy/views/screens/savings_screen/savings.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/bottom_navigation_bar.dart';
import 'package:expensy/views/widgets/budget_stats_screen_widgets/spline_area_chart.dart';
import 'package:expensy/views/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';

class BudgetStats extends StatefulWidget {
  const BudgetStats({super.key});

  @override
  State<BudgetStats> createState() => _BudgetStatsState();
}

class _BudgetStatsState extends State<BudgetStats> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the respective screen
    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Overview()));
    } else if (index == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Savings()));
    } else if (index == 2) {
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (_) => const NotificationScreen()));
    } else if (index == 3) {
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomizedAppBar(
          title: "Budget And Statistics",
          showImage: true,
          showBackButton: false,
          backgroundColor: DarkMode.neutralColor,
          titleAlignment: MainAxisAlignment.center,
        ),
        floatingActionButton: FloatingActionButtonWidget(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Add()),
            )
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        backgroundColor: DarkMode.backgroundColor,
        body: ListView(
            scrollDirection: Axis.vertical, children: [SplineAreaChart()]),
      ),
    );
  }
}
