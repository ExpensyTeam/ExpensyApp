import 'package:expensy/views/screens/notifications_screen/notifications_screen.dart';
import 'package:expensy/views/screens/overview_screen/overview.dart';
import 'package:expensy/views/screens/savings_screen/savings.dart';
import 'package:flutter/material.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/bottom_navigation_bar.dart';
import 'set_reminder.dart';
import 'package:expensy/views/widgets/floating_action_button.dart';

class ReminderItem {
  final String reminderDate;
  final String title;
  final double amount;
  final String dueDate;

  ReminderItem({
    required this.reminderDate,
    required this.title,
    required this.amount,
    required this.dueDate,
  });
}

class ReminderList extends StatefulWidget {
  const ReminderList({Key? key}) : super(key: key);

  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  int _selectedIndex = 3;
  final List<ReminderItem> reminders = [
    ReminderItem(
      reminderDate: '26 May 2024',
      title: 'Bill Payment',
      amount: 200,
      dueDate: '3 Jun 2024',
    ),
    ReminderItem(
      reminderDate: '26 May 2024',
      title: 'Car Loan',
      amount: 600,
      dueDate: '11 July 2024',
    ),
    ReminderItem(
      reminderDate: '26 May 2024',
      title: 'Iphone 15 Pro',
      amount: 1000,
      dueDate: '3 Aug 2024',
    ),
    ReminderItem(
      reminderDate: '26 May 2024',
      title: 'New Bike',
      amount: 2300,
      dueDate: '12 Sep 2024',
    ),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Overview()));
    } else if (index == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Savings()));
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
    return Scaffold(
      backgroundColor: DarkMode.backgroundColor,
      appBar: CustomizedAppBar(
        title: 'Reminders',
        showImage: false,
        titleAlignment: MainAxisAlignment.center,
      ),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          final reminder = reminders[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reminder Date: ${reminder.reminderDate}',
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                    const Icon(Icons.more_horiz, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reminder.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Due on',
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${reminder.amount.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      reminder.dueDate,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                if (index < reminders.length - 1)
                  Divider(color: Colors.grey[800], height: 32),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SetReminder()),
          )
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
