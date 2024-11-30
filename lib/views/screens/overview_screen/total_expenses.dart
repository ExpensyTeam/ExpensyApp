import 'package:expensy/views/screens/overview_screen/overview.dart';
import 'package:expensy/views/screens/savings_screen/savings.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/bottom_navigation_bar.dart';
import 'package:expensy/views/widgets/floating_action_button.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/calender.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/spend_circle.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/spends_categories_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting

class TotalExpensesScreen extends StatefulWidget {
  const TotalExpensesScreen({Key? key}) : super(key: key);

  @override
  _TotalExpensesScreenState createState() => _TotalExpensesScreenState();
}

class _TotalExpensesScreenState extends State<TotalExpensesScreen> {
  int _selectedIndex = 0;
  DateTime _selectedDate = DateTime.now(); // Field to store the selected date

  // Method to update the selected date
  void _updateSelectedDate(String formattedDate) {
    setState(() {
      _selectedDate = DateFormat('dd MM yyyy')
          .parse(formattedDate); // Convert String back to DateTime
    });
  }

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: DarkMode.primaryColor,
        appBar: CustomizedAppBar(
          title: "Total Expenses",
          titleAlignment: MainAxisAlignment.spaceEvenly,
          showImage: false,
          showBackButton: true,
          backgroundColor: DarkMode.neutralColor,
        ),
        floatingActionButton: FloatingActionButtonWidget(
          onPressed: () => {print("this is floating button")},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        body: ListView(
          children: [
            // CalendarWidget with a callback to update selected date
            Container(
              decoration: BoxDecoration(
                color: DarkMode.neutralColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(30),
              child: CalendarWidget(
                selectedDate: _selectedDate,
                onDateSelected: _updateSelectedDate, // Pass the update function
              ),
            ),
            SpendCircleWidget(selectedDate: _selectedDate),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: DarkMode.neutralColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: SpendsCategoriesList(),
            ),
          ],
        ),
      ),
    );
  }
}
