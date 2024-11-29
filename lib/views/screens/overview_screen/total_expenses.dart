// import 'package:expensy/Data/pieChartData.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/calender.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/spend_circle.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/spends_categories_list.dart';
// import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/pie_chart.dart';
import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

class TotalExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: DarkMode.primaryColor,
        appBar: CustomizedAppBar(
          title: "Total Expenses",
          titleAlignment: MainAxisAlignment.spaceEvenly,
          showImage: false,
          showBackButton: true,
          backgroundColor: DarkMode.neutralColor,
        ),
        body: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: DarkMode.neutralColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(30),
              child: CalendarWidget(),
            ),
            SpendCircleWidget(),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: DarkMode.neutralColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: SpendsCategoriesList(),
            ),
          ],
        ),
      ),
    );
  }
}
