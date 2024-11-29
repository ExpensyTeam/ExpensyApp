import 'package:expensy/views/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TransactionPieChart extends StatelessWidget {
  final List<Transactionn> transactions = [
    Transactionn('Food', 100),
    Transactionn('Entertainment', 200),
    Transactionn('Transport', 50),
    Transactionn('Utilities', 150),
  ];

  @override
  Widget build(BuildContext context) {
    double totalAmount = transactions.fold(0, (sum, item) => sum + item.amount);

    List<_PieData> pieData = transactions.map((transaction) {
      double percentage = (transaction.amount / totalAmount) * 100;
      return _PieData(
        transaction.type,
        percentage,
        '${percentage.toStringAsFixed(1)}%',
        _getColor(transaction.type),
      );
    }).toList();

    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: DarkMode.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Center(
        child: SfCircularChart(
          legend: Legend(
            isVisible: true,
            textStyle: TextStyle(color: Colors.white),
          ),
          series: <PieSeries<_PieData, String>>[
            PieSeries<_PieData, String>(
              explode: true,
              explodeIndex: 0,
              dataSource: pieData,
              xValueMapper: (_PieData data, _) => data.xData,
              yValueMapper: (_PieData data, _) => data.yData,
              dataLabelMapper: (_PieData data, _) => data.text,
              pointColorMapper: (_PieData data, _) => data.color,
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

  Color _getColor(String type) {
    switch (type) {
      case 'Food':
        return DarkMode.pieChartColor1;
      case 'Entertainment':
        return DarkMode.pieChartColor3;
      case 'Transport':
        return DarkMode.pieChartColor4;
      case 'Utilities':
        return DarkMode.pieChartColor5;
      default:
        return DarkMode.pieChartColor6;
    }
  }
}

class _PieData {
  _PieData(this.xData, this.yData, this.text, this.color);
  final String xData;
  final num yData;
  final String? text;
  final Color color;
}

class Transactionn {
  final String type;
  final double amount;

  Transactionn(this.type, this.amount);
}
