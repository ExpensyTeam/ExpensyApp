// import 'package:flutter/material.dart';
// // import 'package:charts_flutter/flutter.dart' as charts;

// class PieChartWidget extends StatelessWidget {
//   final List<charts.Series<dynamic, String>> seriesList;

//   PieChartWidget({required this.seriesList});

//   @override
//   Widget build(BuildContext context) {
//     return charts.PieChart(
//       seriesList,
//       animate: true,
//       behaviors: [
//         charts.DatumLegend(
//           outsideJustification: charts.OutsideJustification.endDrawArea,
//           horizontalFirst: false,
//           desiredMaxRows: 2,
//           cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
//           entryTextStyle: charts.TextStyleSpec(
//             color: charts.MaterialPalette.white,
//             fontFamily: 'Georgia',
//             fontSize: 11,
//           ),
//         )
//       ],
//       defaultRenderer: charts.ArcRendererConfig(
//         arcWidth: 60,
//         arcRendererDecorators: [
//           charts.ArcLabelDecorator(
//             labelPosition: charts.ArcLabelPosition.inside,
//           ),
//         ],
//       ),
//     );
//   }
// }
