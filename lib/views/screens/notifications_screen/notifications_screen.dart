import 'package:flutter/material.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/bottom_navigation_bar.dart';
//import 'package:expensy/views/widgets/floating_action_button.dart';
import 'package:expensy/views/screens/reminder_screen/reminder_screen.dart';
import 'package:expensy/views/screens/overview_screen/overview.dart';
import 'package:expensy/views/screens/savings_screen/savings.dart';


class NotificationItem {
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final Color iconBgColor;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.iconBgColor,
  });
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _selectedIndex = 2;
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Food',
      message: 'You just paid your food bill',
      time: 'Just now',
      icon: Icons.fastfood,
      iconBgColor: DarkMode.iconBackground,
    ),
    NotificationItem(
      title: 'Reminder',
      message: 'Reminder to pay your rent',
      time: '23 sec ago',
      icon: Icons.home,
      iconBgColor: DarkMode.iconBackground,
    ),
    NotificationItem(
      title: 'Goal Achived',
      message: 'You just achived your goal for new bike',
      time: '2 min ago',
      icon: Icons.motorcycle,
      iconBgColor: DarkMode.iconBackground,
    ),
    NotificationItem(
      title: 'Reminder',
      message: 'You just set a new reminder shopping',
      time: '10 min ago',
      icon: Icons.shopping_bag,
      iconBgColor: DarkMode.iconBackground,
    ),
    NotificationItem(
      title: 'Food',
      message: 'You just paid your food bill',
      time: '45 min ago',
      icon: Icons.fastfood,
      iconBgColor: DarkMode.iconBackground,
    ),
    NotificationItem(
      title: 'Bill',
      message: 'You just got a reminder for your bill pay',
      time: '1 hour ago',
      icon: Icons.receipt,
      iconBgColor: DarkMode.iconBackground,
    ),
    NotificationItem(
      title: 'Uber',
      message: 'You just paid your uber bill',
      time: '2 hour ago',
      icon: Icons.bike_scooter,
      iconBgColor: DarkMode.iconBackground,
    ),
    NotificationItem(
      title: 'Ticket',
      message: 'You just paid for the movie ticket',
      time: '5 hour ago',
      icon: Icons.local_movies,
      iconBgColor: DarkMode.iconBackground,
    ),
  ];

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
       Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const NotificationsScreen()),
       );
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
        title: 'Notification',
        showImage: false,
        titleAlignment: MainAxisAlignment.center,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Column(
            children: [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: notification.iconBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    notification.icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                title: Text(
                  notification.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  notification.message,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      notification.time,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const Icon(
                      Icons.more_horiz,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              if (index < notifications.length - 1)
                Divider(
                  color: Colors.grey[800],
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}