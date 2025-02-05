import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_bloc.dart';
import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_event.dart';
import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_state.dart';
import 'package:expensy/bloc/saving%20block/saving_block.dart';
import 'package:expensy/bloc/saving%20block/saving_event.dart';
import 'package:expensy/bloc/saving%20block/saving_state.dart';
import 'package:expensy/views/screens/savings_screen/goals.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expensy/views/screens/savings_screen/addGoal.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/bottom_navigation_bar.dart';
import 'package:expensy/views/widgets/floating_action_button.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/spend_circle.dart';
import 'package:intl/intl.dart';

class Savings extends StatefulWidget {
  const Savings({Key? key}) : super(key: key);

  @override
  State<Savings> createState() => _SavingsState();
}

class _SavingsState extends State<Savings> {
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
    DateTime now = DateTime.now();

    return WillPopScope(
        onWillPop: () async {
          context.read<BottomNavBloc>().add(PopNavigationStack());
          return true;
        },
        child: BlocProvider(
          create: (_) => SavingBloc()..add(LoadGoals()),
          child: Scaffold(
            appBar: CustomizedAppBar(
              title: "Savings",
              titleAlignment: MainAxisAlignment.center,
              showImage: false,
              showBackButton: true,
              backgroundColor: DarkMode.neutralColor,
            ),
            floatingActionButton: FloatingActionButtonWidget(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddGoalPage()),
                )
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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
            backgroundColor: DarkMode.primaryColor,
            body: BlocBuilder<SavingBloc, SavingState>(
              builder: (context, state) {
                if (state is SavingLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is SavingError) {
                  return Center(child: Text(state.message));
                }

                if (state is SavingLoaded) {
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      SpendCircleWidget(selectedDate: now),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: DarkMode.neutralColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month,
                                      color: Colors.white),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${DateFormat.yMMMM().format(now)}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                "Goal for this Month",
                                style: TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(height: 12),
                              // Add a progress bar here based on the goal progress
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: DraggableScrollableSheet(
                          initialChildSize: 0.80,
                          minChildSize: 0.80,
                          maxChildSize: 1.0,
                          builder: (context, scrollController) {
                            return Goals(
                                scrollController: scrollController,
                                goals: state.goals);
                          },
                        ),
                      ),
                    ],
                  );
                }

                return Center(child: Text("No Data Available"));
              },
            ),
          ),
        ));
  }
}

class Goals extends StatelessWidget {
  final ScrollController scrollController;
  final List<Map<String, dynamic>> goals;

  const Goals({Key? key, required this.scrollController, required this.goals})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DarkMode.neutralColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Your Goals",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  context.read<BottomNavBloc>().add(ChangeBottomNavIndex(1));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoalsScreen(goals: goals),
                    ),
                  );
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.shade800,
                  ),
                  child: const Icon(Icons.more_horiz, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: goals.length,
              itemBuilder: (context, index) {
                final goal = goals[index];
                IconData icon;

                switch (goal["title"]) {
                  case "New Bike":
                    icon = Icons.motorcycle;
                    break;
                  case "iPhone 15 Pro":
                    icon = Icons.phone_iphone;
                    break;
                  default:
                    icon = Icons.star;
                }

                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                goal["title"],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              LinearProgressIndicator(
                                value: goal["current"] / goal["goal"],
                                backgroundColor: Colors.grey.shade800,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    DarkMode.buttonColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "\$${goal["current"]} / \$${goal["goal"]}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
