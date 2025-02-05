import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_bloc.dart';
import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_event.dart';
import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_state.dart';
import 'package:expensy/views/screens/overview_screen/add.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/bottom_navigation_bar.dart';
import 'package:expensy/views/widgets/floating_action_button.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/calender.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/spend_circle.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/spends_categories_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting

class TotalExpensesScreen extends StatefulWidget {
  const TotalExpensesScreen({Key? key}) : super(key: key);

  @override
  _TotalExpensesScreenState createState() => _TotalExpensesScreenState();
}

class _TotalExpensesScreenState extends State<TotalExpensesScreen> {
  DateTime _selectedDate = DateTime.now(); // Field to store the selected date

  // Method to update the selected date
  void _updateSelectedDate(String formattedDate) {
    setState(() {
      _selectedDate = DateFormat('dd MM yyyy')
          .parse(formattedDate); // Convert String back to DateTime
    });
  }

  void _navigateToScreen(BuildContext context, int index) {
    if (index != context.read<BottomNavBloc>().state.selectedIndex) {
      context.read<BottomNavBloc>().add(ChangeBottomNavIndex(index));
      switch (index) {
        case 0:
          Navigator.popAndPushNamed(context, '/home');
          break;
        case 1:
          Navigator.popAndPushNamed(context, '/saving');
          break;
        case 2:
          Navigator.popAndPushNamed(context, '/notifications');
          break;
        case 3:
          Navigator.popAndPushNamed(context, '/reminders');
          break;
      }
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
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Add()),
          )
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          return CustomBottomNavBar(
            selectedIndex: state.selectedIndex,
            onItemTapped: (index) {
              _navigateToScreen(context, index);
            },
          );
        },
      ),
      body: ListView(children: [
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
        // DraggableScrollableSheet(
        //   initialChildSize: 0.68,
        //   minChildSize: 0.68,
        //   maxChildSize: 1,
        //   builder: (context, scrollController) {
        //     return SpendsCategoriesList(scrollController: scrollController);
        //   },
        // )
        ExpenseCategoriesList(selectedDate: _selectedDate)
      ]),
    ));
  }
}
