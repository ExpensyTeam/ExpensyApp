import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_bloc.dart';
import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_event.dart';
import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_state.dart';
import 'package:expensy/bloc/notificaton%20block/notification_bloc.dart';
import 'package:expensy/bloc/notificaton%20block/notification_event.dart';
import 'package:expensy/bloc/notificaton%20block/notification_state.dart';
import 'package:expensy/views/screens/overview_screen/add.dart';
import 'package:expensy/views/widgets/floating_action_button.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  void _navigateToScreen(BuildContext context, int index) {
    if (index != context.read<BottomNavBloc>().state.selectedIndex) {
      context.read<BottomNavBloc>().add(ChangeBottomNavIndex(index));
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/home');
          break;
        case 1:
          Navigator.pushNamed(context, '/saving');
          break;
        case 2:
          Navigator.pushNamed(context, '/notifications');
          break;
        case 3:
          Navigator.pushNamed(context, '/reminders');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context.read<BottomNavBloc>().add(PopNavigationStack());
          return true;
        },
        child: BlocProvider(
          create: (_) => NotificationBloc()..add(LoadNotifications()),
          child: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is NotificationLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NotificationLoaded) {
                return Scaffold(
                  backgroundColor: DarkMode.backgroundColor,
                  appBar: CustomizedAppBar(
                    title: 'Notification',
                    showImage: false,
                    titleAlignment: MainAxisAlignment.center,
                  ),
                  floatingActionButton: FloatingActionButtonWidget(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Add()),
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  bottomNavigationBar:
                      BlocBuilder<BottomNavBloc, BottomNavState>(
                    builder: (context, state) {
                      return CustomBottomNavBar(
                        selectedIndex: state.selectedIndex,
                        onItemTapped: (index) {
                          _navigateToScreen(context, index);
                        },
                      );
                    },
                  ),
                  body: ListView.builder(
                    itemCount: state.notifications.length,
                    itemBuilder: (context, index) {
                      final notification = state.notifications[index];
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  notification.time,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                // const Icon(
                                //   Icons.more_horiz,
                                //   color: Colors.grey,
                                // ),
                              ],
                            ),
                          ),
                          if (index < state.notifications.length - 1)
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
                );
              } else if (state is NotificationError) {
                return Center(
                  child: Text(
                    'Failed to load notifications: ${state.message}',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ));
  }
}
