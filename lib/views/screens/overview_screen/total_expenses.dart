// import 'package:expensy/Data/pieChartData.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/calender.dart';
// import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/pie_chart.dart';
import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

class TotalExpensesScreen extends StatelessWidget {
  // final List<Map<String, Object>> data = pieChart_data;

  // final series = [
  //   charts.Series<Map<String, dynamic>, String>(
  //     id: 'Spending',
  //     domainFn: (datum, _) => datum['category'],
  //     measureFn: (datum, _) => datum['value'],
  //     data: pieChart_data,
  //   )
  // ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomizedAppBar(
            title: "Total Expenses",
            titleAlignment: MainAxisAlignment.spaceEvenly,
            showImage: false,
            showBackButton: true,
            backgroundColor: DarkMode.neutralColor),
        body: ListView(children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: DarkMode.neutralColor,
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(30),
              child: CalendarWidget(),
            ),
          ),
          // PieChartWidget(
          //   seriesList: series,
          // )
        ]),
        backgroundColor: DarkMode.backgroundColor,
      ),
    );
  }
}
