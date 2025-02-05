import 'package:flutter/material.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'dart:ui';
import 'package:expensy/views/widgets/set_reminder_screen_widgets/custom_calendar.dart';

import 'package:expensy/Data/goals_data.dart';

class AddGoalPage extends StatefulWidget {
  const AddGoalPage({Key? key}) : super(key: key);

  @override
  State<AddGoalPage> createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  List<Map<String, dynamic>> goals = goals_data;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _goalTitleController = TextEditingController();
  String selectedFrequency = 'Select One';
  DateTime selectedDate = DateTime.now();
  bool showFrequencyModal = false;
  bool showDateModal = false;

  final List<String> frequencyOptions = [
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly'
  ];

  Widget _buildBlurredBackground(Widget child) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Center(child: child),
      ],
    );
  }

  Widget _buildFrequencySelector() {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: DarkMode.neutralColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: frequencyOptions.length,
          itemBuilder: (context, index) {
            final option = frequencyOptions[index];
            return ListTile(
              title: Text(
                option,
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                setState(() {
                  selectedFrequency = option;
                  showFrequencyModal = false;
                });
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: DarkMode.backgroundColor,
          appBar: CustomizedAppBar(
            title: 'Add Goal',
            showImage: false,
            titleAlignment: MainAxisAlignment.center,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Goal Title',
                  style: TextStyle(color: Colors.grey[400], fontSize: 16),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _goalTitleController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Amount',
                  style: TextStyle(color: Colors.grey[400], fontSize: 16),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _amountController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                      suffixText: '\$',
                      suffixStyle: TextStyle(color: Colors.white),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Contribution Type',
                  style: TextStyle(color: Colors.grey[400], fontSize: 16),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => setState(() => showFrequencyModal = true),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedFrequency,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Date',
                  style: TextStyle(color: Colors.grey[400], fontSize: 16),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => setState(() => showDateModal = true),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDate.toString().split(' ')[0],
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Icon(Icons.calendar_today, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: DarkMode.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (_amountController.text.isNotEmpty &&
                          _goalTitleController.text.isNotEmpty &&
                          selectedFrequency != "Select One") {
                        final double? goalAmount =
                            double.tryParse(_amountController.text);

                        if (goalAmount != null && goalAmount > 0) {
                          // Add the transaction to the list
                          setState(() {
                            goals.add({
                              "title": _goalTitleController.text,
                              "current": 0,
                              "goal": goalAmount,
                              "Frequency": selectedFrequency,
                            });
                          });

                          // Clear inputs
                          _amountController.clear();
                          _goalTitleController.clear();
                          selectedFrequency = "";

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Transaction added successfully!')),
                          );

                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Invalid amount. Please enter a valid numeric value.')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'All fields are required. Please fill in all the fields.')),
                        );
                      }
                    },
                    child: const Text(
                      'ADD GOAL',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showFrequencyModal)
          _buildBlurredBackground(_buildFrequencySelector()),
        if (showDateModal)
          _buildBlurredBackground(
            Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: DarkMode.neutralColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomCalendar(
                  selectedDate: selectedDate,
                  onDateSelected: (formattedDate) {
                    setState(() {
                      selectedDate = formattedDate;
                      showDateModal = false;
                    });
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}
