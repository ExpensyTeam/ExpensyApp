import 'package:flutter/material.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/Data/transactions.dart'; // Assuming transactions_data is imported here
import 'package:intl/intl.dart';

class SpendCircleWidget extends StatelessWidget {
  final DateTime selectedDate;

  const SpendCircleWidget({super.key, required this.selectedDate});

  // Helper function to parse the date from the string format to DateTime
  DateTime _parseDate(String dateString) {
    final DateFormat formatter = DateFormat('d MMMM yyyy'); // Your date format
    return formatter.parse(dateString);
  }

  double _getTotalSpend(DateTime date) {
    // Filter the transactions based on the selected date
    final totalSpend = transactions_data.where((transaction) {
      // Only consider expense transactions (amount starts with '-')
      final transactionDate = _parseDate(transaction.date);
      return transaction.amount.startsWith('-') &&
          transactionDate.isBefore(date.add(const Duration(days: 1)));
    }).fold<double>(
      0.0,
      (sum, transaction) {
        // Remove the '$' sign and parse the amount as a double
        final amount = double.parse(transaction.amount.substring(2));
        return sum + amount;
      },
    );

    return totalSpend;
  }

  double _getBudget() {
    // You can replace this with logic to get the user's total budget
    return 3000.0; // Example: $3000 total budget
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the total spend and calculate the percentage
    double totalSpend = _getTotalSpend(selectedDate);
    double budget = _getBudget();
    double percentageSpent = (totalSpend / budget) * 100;

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
            // Center content (display the total spend)
            Center(
              child: Text(
                "\$${totalSpend.toStringAsFixed(2)}", // Display spend with two decimal places
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Container(
          width: 140,
          child: Text(
            "You have spent ${percentageSpent.toStringAsFixed(2)}% of your budget",
            style: TextStyle(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
