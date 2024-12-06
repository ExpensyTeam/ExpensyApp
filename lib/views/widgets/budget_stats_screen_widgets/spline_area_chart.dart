import 'package:expensy/views/themes/colors.dart';
import 'package:intl/intl.dart';
import 'package:expensy/Data/transactions.dart';
import 'package:expensy/utils/transaction.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final String x; // "Month Year" (e.g., "January 2024")
  final double y; // Income (positive amount)
  final double y1; // Expense (negative amount)
}

class SplineAreaChart extends StatefulWidget {
  @override
  _SplineAreaChartState createState() => _SplineAreaChartState();
}

class _SplineAreaChartState extends State<SplineAreaChart> {
  int selectedYear = DateTime.now().year; // Default year to the current year

  // Function to filter transactions by year
  List<Transaction> _getTransactionsForYear(int year) {
    List<Transaction> transactionsData = transactions_data;
    return transactionsData.where((transaction) {
      DateTime transactionDate =
          DateFormat("d MMMM yyyy").parse(transaction.date);
      return transactionDate.year == year;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Fetch transactions for the selected year
    List<Transaction> transactionsData = _getTransactionsForYear(selectedYear);

    // Create a map to store total income and expense for each (month, year)
    Map<String, double> monthlyIncome = {};
    Map<String, double> monthlyExpense = {};

    // Create a DateFormat to match the date format "13 MMMM yyyy"
    DateFormat format = DateFormat("d MMMM yyyy");

    // Loop through each transaction and aggregate data by month and year
    for (var transaction in transactionsData) {
      double amount =
          double.parse(transaction.amount.replaceAll(RegExp(r'[^\d.-]'), ''));
      DateTime transactionDate = format.parse(transaction.date);

      // Format the date as "Month Year"
      String monthYear = DateFormat('MMMM yyyy').format(transactionDate);

      // Aggregate income and expense based on the amount
      if (amount > 0) {
        monthlyIncome[monthYear] =
            (monthlyIncome[monthYear] ?? 0) + amount; // Aggregate income
      } else {
        monthlyExpense[monthYear] =
            (monthlyExpense[monthYear] ?? 0) + amount; // Aggregate expense
      }
    }

    // Prepare chart data by combining monthly income and expenses
    List<ChartData> chartData = [];

    // Sort months in chronological order
    List<String> sortedMonthYears = monthlyIncome.keys.toList();
    sortedMonthYears.sort((a, b) => DateFormat('MMMM yyyy')
        .parse(a)
        .compareTo(DateFormat('MMMM yyyy').parse(b)));

    for (String monthYear in sortedMonthYears) {
      double income = monthlyIncome[monthYear] ?? 0;
      double expense = monthlyExpense[monthYear] ?? 0;
      chartData.add(ChartData(monthYear, income, expense.abs()));
    }

    return Column(children: [
      // Dropdown to select year
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Choose a given year :",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Container(
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: DarkMode.neutralColor,
              ),
              // padding: EdgeInsets.all(10),
              child: DropdownButton<int>(
                value: selectedYear,
                items: List.generate(10, (index) {
                  int year =
                      DateTime.now().year - index; // Generate the last 10 years
                  return DropdownMenuItem<int>(
                    value: year,
                    child: Text(year.toString()),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    selectedYear = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      // Chart displaying data for the selected year
      Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            width: 600,
            height: 450,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: DarkMode.neutralColor),
            child: SfCartesianChart(
              plotAreaBackgroundColor: DarkMode.neutralColor,
              primaryXAxis:
                  CategoryAxis(), // Use CategoryAxis for x-axis with custom labels
              series: <CartesianSeries>[
                SplineAreaSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'Income',
                  opacity: 0.7, // Make the income line a little transparent
                  color: DarkMode.pieChartColor1,
                ),
                SplineAreaSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y1,
                  name: 'Expense',
                  opacity: 0.7, // Make the expense line a little transparent
                  color: DarkMode.pieChartColor5,
                ),
              ],
              title: ChartTitle(
                  text: 'Comparison of Incomes and Expenses for $selectedYear'),
              legend: Legend(isVisible: true),
              trackballBehavior: TrackballBehavior(
                enable: true,
                activationMode: ActivationMode.singleTap,
                tooltipSettings: InteractiveTooltip(
                  enable: true,
                  format: 'point.x : point.y',
                ),
              ),
            ),
          )),
    ]);
  }
}
