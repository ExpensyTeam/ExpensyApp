import 'package:expensy/views/screens/overview_screen/add.dart';
import 'package:expensy/views/screens/overview_screen/overview.dart';
import 'package:expensy/views/screens/savings_screen/savings.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/bottom_navigation_bar.dart';
import 'package:expensy/views/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

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
    return Scaffold(
      appBar: CustomizedAppBar(
        title: "Add Expense",
        titleAlignment: MainAxisAlignment.center,
        showImage: false,
        showBackButton: true,
        backgroundColor: DarkMode.neutralColor,
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
      body: Center(
        child: Text(
          "This is the add expense screen.",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      backgroundColor: DarkMode.backgroundColor,
    );
  }
}
