import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

// Import statements remain the same as in original file
import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_bloc.dart';
import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_event.dart';
import 'package:expensy/bloc/bottom_nav%20bloc/bottom_nav_state.dart';
import 'package:expensy/bloc/saving%20block/saving_block.dart';
import 'package:expensy/bloc/saving%20block/saving_event.dart';
import 'package:expensy/bloc/saving%20block/saving_state.dart';
import 'package:expensy/views/screens/savings_screen/goals.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/screens/savings_screen/addGoal.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/bottom_navigation_bar.dart';
import 'package:expensy/views/widgets/floating_action_button.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/spend_circle.dart';

class Savings extends StatefulWidget {
  const Savings({Key? key}) : super(key: key);

  @override
  State<Savings> createState() => _SavingsState();
}

class _SavingsState extends State<Savings> {
  final TextEditingController _amountController = TextEditingController();
  Map<String, dynamic>? _selectedGoal;
  bool _showUpdatePrice = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

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

  Widget _buildBlurredBackground(Widget child) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        child,
      ],
    );
  }

  Widget _buildGoalUpdateWidget() {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: DarkMode.neutralColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_selectedGoal != null) ...[
                Card(
                  color: Colors.grey.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          _selectedGoal!["title"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "\$${_selectedGoal!["current"]} / \$${_selectedGoal!["goal"]}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter amount",
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    filled: true,
                    fillColor: Colors.grey.shade800,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [10, 50, 100].map((amount) {
                    return ElevatedButton(
                      onPressed: () {
                        double currentAmount =
                            double.tryParse(_amountController.text) ?? 0.0;
                        _amountController.text =
                            (currentAmount + amount).toStringAsFixed(2);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DarkMode.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("+\$${amount.toString()}"),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() => _showUpdatePrice = false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                      ),
                      child: const Text("Close"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        double amount =
                            double.tryParse(_amountController.text) ?? 0.0;
                        if (amount > 0) {
                          setState(() {
                            _selectedGoal!["current"] += amount;
                            _amountController.clear();
                            _showUpdatePrice = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DarkMode.buttonColor,
                      ),
                      child: const Text("Update"),
                    ),
                  ],
                ),
              ] else
                const Text(
                  "No goal selected",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        context.read<BottomNavBloc>().add(PopNavigationStack());
        return true;
      },
      child: BlocProvider(
        create: (_) => SavingBloc()..add(LoadGoals()),
        child: Stack(
          children: [
            Scaffold(
              appBar: CustomizedAppBar(
                title: "Savings",
                titleAlignment: MainAxisAlignment.center,
                showImage: false,
                showBackButton: true,
                backgroundColor: DarkMode.neutralColor,
              ),
              floatingActionButton: FloatingActionButtonWidget(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddGoalPage()),
                  );
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BlocBuilder<BottomNavBloc, BottomNavState>(
                builder: (context, state) {
                  return CustomBottomNavBar(
                    selectedIndex: state.selectedIndex,
                    onItemTapped: (index) => _navigateToScreen(context, index),
                  );
                },
              ),
              backgroundColor: DarkMode.primaryColor,
              body: BlocBuilder<SavingBloc, SavingState>(
                builder: (context, state) {
                  if (state is SavingLoading) {
                    return const Center(child: CircularProgressIndicator());
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
                                      DateFormat.yMMMM().format(now),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  "Goal for this Month",
                                  style: TextStyle(color: Colors.white70),
                                ),
                                const SizedBox(height: 12),
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
                                goals: state.goals,
                                onGoalSelected: (goal) {
                                  setState(() {
                                    _selectedGoal = goal;
                                    _showUpdatePrice = true;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }

                  return const Center(child: Text("No Data Available"));
                },
              ),
            ),
            if (_showUpdatePrice && _selectedGoal != null)
              _buildBlurredBackground(_buildGoalUpdateWidget()),
          ],
        ),
      ),
    );
  }
}

class Goals extends StatelessWidget {
  final ScrollController scrollController;
  final List<Map<String, dynamic>> goals;
  final Function(Map<String, dynamic>) onGoalSelected;

  const Goals({
    Key? key,
    required this.scrollController,
    required this.goals,
    required this.onGoalSelected,
  }) : super(key: key);

  IconData _getIconForGoal(String title) {
    switch (title) {
      case "New Bike":
        return Icons.motorcycle;
      case "iPhone 15 Pro":
        return Icons.phone_iphone;
      case "Vacation Fund":
        return Icons.flight_takeoff;
      case "Gaming Console":
        return Icons.videogame_asset;
      case "Home Gym":
        return Icons.fitness_center;
      default:
        return Icons.star;
    }
  }

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
                  fontWeight: FontWeight.bold,
                ),
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
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () => onGoalSelected(goal),
                    borderRadius: BorderRadius.circular(12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getIconForGoal(goal["title"]),
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              LinearProgressIndicator(
                                value: goal["current"] / goal["goal"],
                                backgroundColor: Colors.grey.shade800,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  DarkMode.buttonColor,
                                ),
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GoalWidget extends StatelessWidget {
  final Map<String, dynamic> goal;
  final IconData icon;

  const GoalWidget({
    Key? key,
    required this.goal,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: DarkMode.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal["title"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "\$${goal["current"]}",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
