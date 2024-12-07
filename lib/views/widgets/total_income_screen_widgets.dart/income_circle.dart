import 'package:flutter/material.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:intl/intl.dart';

class IncomeCircleWidget extends StatelessWidget {
  final DateTime selectedDate;

  const IncomeCircleWidget({super.key, required this.selectedDate});

  double _getTotalIncome(DateTime date) {
    // Filter the transactions based on the selected date

    return 800.0;
  }

  double _getBudget() {
    // You can replace this with logic to get the user's total budget
    return 3000.0; // Example: $3000 total budget
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the total Income and calculate the percentage
    double totalIncome = _getTotalIncome(selectedDate);
    double budget = _getBudget();

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Outer border
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: const Color.fromRGBO(57, 67, 76, 0.471), width: 10),
              ),
            ),
            // Inner border
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color.fromRGBO(82, 92, 101, 1), width: 10),
                  color: DarkMode.buttonColor),
            ),
            // Center content (display the total Income)
            Center(
              child: Text(
                "\$$totalIncome",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
