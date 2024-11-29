// import 'package:expensy/Data/iconMapping.dart';
// import 'package:expensy/Data/transactions.dart';
// import 'package:expensy/utils/transaction.dart';
// import 'package:expensy/views/themes/colors.dart';
// import 'package:flutter/material.dart';

// class SpendsCategoriesList extends StatefulWidget {
//   @override
//   _SpendsCategoriesListState createState() => _SpendsCategoriesListState();
// }

// class _SpendsCategoriesListState extends State<SpendsCategoriesList> {
//   List<Transaction> transactions = transactions_data;

//   // Define a map to associate transaction types with specific icons
//   final Map<String, IconData> iconMapping = iconMapping_data;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(height: 15),
//         Expanded(
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: transactions.length,
//             itemBuilder: (context, index) {
//               final transaction = transactions[index];

//               final icon = iconMapping[transaction.type] ?? Icons.help_outline;

//               return ListTile(
//                 leading: Container(
//                   width: 45,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: DarkMode.iconBackground,
//                     borderRadius:
//                         BorderRadius.circular(10), // Adjust radius as needed
//                   ),
//                   child: Icon(
//                     icon, // Use the corresponding icon for the transaction type
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                 title: Text(transaction.type,
//                     style: TextStyle(color: Colors.white, fontSize: 20)),
//                 subtitle: Text(transaction.date,
//                     style: TextStyle(color: Colors.white70)),
//                 trailing: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text('${transaction.amount} + VAT ${transaction.vat}',
//                         style: TextStyle(color: Colors.white, fontSize: 18)),
//                     Text(transaction.method,
//                         style: TextStyle(color: Colors.white70, fontSize: 15)),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:expensy/Data/iconMapping.dart';
import 'package:expensy/Data/transactions.dart';
import 'package:expensy/utils/transaction.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/pie_chart.dart';
import 'package:flutter/material.dart';

class SpendsCategoriesList extends StatefulWidget {
  @override
  _SpendsCategoriesListState createState() => _SpendsCategoriesListState();
}

class _SpendsCategoriesListState extends State<SpendsCategoriesList> {
  List<Transaction> transactions = transactions_data;

  final Map<String, IconData> iconMapping = iconMapping_data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ElevatedButton(onPressed: () => {}, child: Text("spends")),
            ElevatedButton(onPressed: () => {}, child: Text("Categories"))
          ]),
        ),
        TransactionPieChart(),
        // SizedBox(height: 10),
        Container(
          height: MediaQuery.of(context).size.height *
              0.5, // Adjust the height as needed
          child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];

              final icon = iconMapping[transaction.type] ?? Icons.help_outline;

              return ListTile(
                leading: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: DarkMode.iconBackground,
                    borderRadius:
                        BorderRadius.circular(10), // Adjust radius as needed
                  ),
                  child: Icon(
                    icon, // Use the corresponding icon for the transaction type
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                title: Text(transaction.type,
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                subtitle: Text(transaction.date,
                    style: TextStyle(color: Colors.white70)),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${transaction.amount} + VAT ${transaction.vat}',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    Text(transaction.method,
                        style: TextStyle(color: Colors.white70, fontSize: 15)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
