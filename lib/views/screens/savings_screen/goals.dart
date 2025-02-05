import 'package:expensy/views/screens/savings_screen/savings.dart';
import 'package:flutter/material.dart';
import 'package:expensy/views/screens/overview_screen/add.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/bottom_navigation_bar.dart';
import 'package:expensy/views/screens/overview_screen/overview.dart';
import 'package:expensy/views/widgets/floating_action_button.dart';
import 'addGoal.dart';

class GoalsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> goals;

  const GoalsScreen({Key? key, required this.goals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(
        title: "Goals",
        titleAlignment: MainAxisAlignment.center,
        showImage: false,
        showBackButton: true,
        backgroundColor: DarkMode.neutralColor,
      ),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddGoalPage()),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1,
        onItemTapped: (int index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Savings(),
            ),
          );
        },
      ),
      backgroundColor: DarkMode.neutralColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "All Goals",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  final goal = goals[index];
                  IconData icon;

                  // Assign icons based on goal titles
                  switch (goal["title"]) {
                    case "New Bike":
                      icon = Icons.motorcycle;
                      break;
                    case "iPhone 15 Pro":
                      icon = Icons.phone_iphone;
                      break;
                    case "Vacation Fund":
                      icon = Icons.flight_takeoff;
                      break;
                    case "Gaming Console":
                      icon = Icons.videogame_asset;
                      break;
                    case "Home Gym":
                      icon = Icons.fitness_center;
                      break;
                    default:
                      icon = Icons.star; // Placeholder icon for unknown goals
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        // Icon container with light grey background
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                Colors.grey.shade800, // Light grey background
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Goal details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    goal["title"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "\$${goal["current"]} / \$${goal["goal"]}",
                                    style:
                                        const TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: (goal["current"] / goal["goal"])
                                    .clamp(0.0, 1.0),
                                backgroundColor: Colors.grey.shade800,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    DarkMode.buttonColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
