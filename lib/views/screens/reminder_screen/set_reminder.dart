import 'package:flutter/material.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'dart:ui';
import 'package:expensy/views/widgets/set_reminder_screen_widgets/custom_calendar.dart';

class SetReminder extends StatefulWidget {
  const SetReminder({Key? key}) : super(key: key);

  @override
  State<SetReminder> createState() => _SetReminderState();
}

class _SetReminderState extends State<SetReminder> {
  final TextEditingController _amountController = TextEditingController();
  String selectedBill = 'Car Nhan';
  String selectedFrequency = 'Select One';
  DateTime selectedDate = DateTime.now();
  bool showBillModal = false;
  bool showFrequencyModal = false;
  bool showDateModal = false;

  final List<String> billOptions = [
    'Car Nhan',
    'Iphone 15 Pro',
    'House',
    'Shopping'
  ];
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

  Widget _buildBillSelector() {
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
          itemCount: billOptions.length,
          itemBuilder: (context, index) {
            final option = billOptions[index];
            return ListTile(
              title: Text(
                option,
                style: TextStyle(
                  color: option == selectedBill ? Colors.blue : Colors.white,
                ),
              ),
              trailing: option == selectedBill
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                setState(() {
                  selectedBill = option;
                  showBillModal = false;
                });
              },
            );
          },
        ),
      ),
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
            title: 'Set Reminders',
            showImage: false,
            titleAlignment: MainAxisAlignment.center,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Bill',
                  style: TextStyle(color: Colors.grey[400], fontSize: 16),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => setState(() => showBillModal = true),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: DarkMode.buttonColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedBill,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
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
                    border: Border.all(color: DarkMode.buttonColor),
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
                  'Frequency',
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
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'SET REMINDER',
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
        if (showBillModal) _buildBlurredBackground(_buildBillSelector()),
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

