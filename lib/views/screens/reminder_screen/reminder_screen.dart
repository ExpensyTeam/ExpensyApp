import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_bloc.dart';
import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_event.dart';
import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_state.dart';
import 'package:expensy/bloc/reminder%20block/reminder_bloc.dart';
import 'package:expensy/bloc/reminder%20block/reminder_event.dart';
import 'package:expensy/bloc/reminder%20block/reminder_state.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/bottom_navigation_bar.dart';
import 'package:expensy/views/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'set_reminder.dart';

class ReminderList extends StatefulWidget {
  const ReminderList({Key? key}) : super(key: key);

  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
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
          create: (_) => ReminderBloc()..add(LoadReminders()),
          child: BlocBuilder<ReminderBloc, ReminderState>(
            builder: (context, state) {
              if (state is ReminderLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ReminderLoaded) {
                return Scaffold(
                  backgroundColor: DarkMode.backgroundColor,
                  appBar: CustomizedAppBar(
                    title: 'Reminders',
                    showImage: false,
                    titleAlignment: MainAxisAlignment.center,
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
                    itemCount: state.reminders.length,
                    itemBuilder: (context, index) {
                      final reminder = state.reminders[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Reminder Date: ${reminder.reminderDate}',
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 14),
                                ),
                                const Icon(Icons.more_horiz,
                                    color: Colors.grey),
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
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 14),
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
                            if (index < state.reminders.length - 1)
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
                        MaterialPageRoute(
                            builder: (context) => const SetReminder()),
                      )
                    },
                  ),
                );
              } else if (state is ReminderError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        ));
  }
}
