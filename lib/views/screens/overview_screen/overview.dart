import 'package:expensy/views/screens/overview_screen/add.dart';
import 'package:expensy/views/screens/savings_screen/savings.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/bottom_navigation_bar.dart';
import 'package:expensy/views/widgets/floating_action_button.dart';
import 'package:expensy/views/widgets/overview_screen_widgets/main_widget_overview.dart';
import 'package:expensy/views/widgets/overview_screen_widgets/top_widget_overview.dart';
import 'package:flutter/material.dart';
import 'package:expensy/views/screens/notifications_screen/notifications_screen.dart';
import 'package:expensy/views/screens/reminder_screen/reminder_screen.dart';




class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
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
       Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const NotificationsScreen()));
    } else if (index == 3) {
      // Uncomment and add the Settings screen when available
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (_) => const ReminderList()),
       );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomizedAppBar(
            title: "Overview",
            showImage: true,
            showBackButton: false,
            backgroundColor: DarkMode.neutralColor,
            titleAlignment: MainAxisAlignment.center,
          ),
          body: Container(
            decoration: BoxDecoration(
              color: DarkMode.primaryColor,
            ),
            child: Stack(
              children: [
                TopOverview(),
                SizedBox(
                  height: 15,
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.68,
                  minChildSize: 0.68,
                  maxChildSize: 1,
                  builder: (context, scrollController) {
                    return Expanded(
                        child:
                            MainOverview(scrollController: scrollController));
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButtonWidget(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Add()),
              )
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          )),
    );
  }
}
