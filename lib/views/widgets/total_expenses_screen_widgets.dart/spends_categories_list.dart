import 'package:expensy/Data/iconMapping.dart';
import 'package:expensy/Data/transactions.dart';
import 'package:expensy/utils/transaction.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/pie_chart.dart';
import 'package:flutter/material.dart';

class SpendsCategoriesList extends StatefulWidget {
  // final ScrollController scrollController;

  // const SpendsCategoriesList({required this.scrollController});

  @override
  _SpendsCategoriesListState createState() => _SpendsCategoriesListState();
}

class _SpendsCategoriesListState extends State<SpendsCategoriesList> {
  List<Transaction> expenses = transactions_data
      .where((transaction) => transaction.amount.startsWith('-'))
      .toList();
  final Map<String, IconData> iconMapping = iconMapping_data ?? {};

  bool isSpendViewSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: DarkMode.neutralColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: SingleChildScrollView(
          // controller: widget.scrollController,
          child: Column(
            children: [
              SpendCategorySelector(),
              if (!isSpendViewSelected) TransactionSemiDoughnutChart(),
              SpendList(),
            ],
          ),
        ));
  }

  Widget SpendCategorySelector() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCategoryButton("Spends", isSpendViewSelected, () {
            setState(() => isSpendViewSelected = true);
          }),
          _buildCategoryButton("Categories", !isSpendViewSelected, () {
            setState(() => isSpendViewSelected = false);
          }),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
      String label, bool isSelected, VoidCallback onPressed) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        border: isSelected
            ? Border(
                bottom: BorderSide(
                  color: DarkMode.buttonColor,
                  width: 3,
                ),
              )
            : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: DarkMode.neutralColor,
          foregroundColor: isSelected ? DarkMode.primaryColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget SpendList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final transaction = expenses[index];
        final icon =
            iconMapping[transaction.type] ?? Icons.attach_money_outlined;

        return ListTile(
          leading: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: DarkMode.iconBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          title: Text(transaction.type,
              style: TextStyle(color: Colors.white, fontSize: 20)),
          subtitle:
              Text(transaction.date, style: TextStyle(color: Colors.white70)),
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
    );
  }
}
