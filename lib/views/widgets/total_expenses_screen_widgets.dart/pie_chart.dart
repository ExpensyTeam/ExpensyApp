import 'package:expensy/Data/transactions.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expensy/utils/PieData.dart';
import 'package:expensy/utils/transaction.dart';
import 'package:expensy/views/themes/colors.dart';

class TransactionPieChart extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionPieChart({Key? key})
      : transactions = transactions_data,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PieData> pieData = calculateCategoryData(transactions);

    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 37, 46, 52),
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Center(
        child: SfCircularChart(
          legend: Legend(
            isVisible: true,
            textStyle: TextStyle(color: Colors.white),
          ),
          series: <PieSeries<PieData, String>>[
            PieSeries<PieData, String>(
              explode: true,
              explodeIndex: 0,
              dataSource: pieData,
              xValueMapper: (PieData data, _) => data.xData,
              yValueMapper: (PieData data, _) => data.yData,
              dataLabelMapper: (PieData data, _) => data.text,
              pointColorMapper: (PieData data, _) => data.color,
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieData> calculateCategoryData(List<Transaction> transactionsData) {
    Map<String, double> categoryTotals = {};

    for (var transaction in transactionsData) {
      double amount = double.tryParse(
              transaction.amount.replaceAll(RegExp(r'[^0-9.]'), '')) ??
          0;
      categoryTotals.update(
        transaction.type,
        (value) => value + amount,
        ifAbsent: () => amount,
      );
    }

    double totalAmount =
        categoryTotals.values.fold(0.0, (sum, amount) => sum + amount);

    List<PieData> pieData = categoryTotals.entries.map((entry) {
      String type = entry.key;
      double totalAmountInCategory = entry.value;
      double percentage = (totalAmountInCategory / totalAmount) * 100;

      return PieData(
        xData: type,
        yData: percentage,
        text: '${percentage.toStringAsFixed(1)}%',
        color: _getColor(type),
      );
    }).toList();

    return pieData;
  }

  Color _getColor(String type) {
    switch (type) {
      case 'Food':
        return DarkMode.pieChartColor1;
      case 'Uber':
        return DarkMode.pieChartColor3;
      case 'Shopping':
        return DarkMode.pieChartColor4;
      case 'Utilities':
        return DarkMode.pieChartColor5;
      default:
        return DarkMode.pieChartColor6;
    }
  }
}
