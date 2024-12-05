import 'package:expensy/Data/cardData.dart';
import 'package:expensy/Data/iconMapping.dart';
import 'package:expensy/Data/transactions.dart';
import 'package:expensy/utils/top_view_card.dart';
import 'package:expensy/utils/transaction.dart';
import 'package:expensy/views/screens/overview_screen/add_expense.dart';
import 'package:expensy/views/screens/overview_screen/add_income.dart';
import 'package:expensy/views/screens/overview_screen/overview.dart';
import 'package:expensy/views/screens/savings_screen/savings.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/bottom_navigation_bar.dart';
import 'package:expensy/views/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  int _selectedIndex = 0;
  String _selectedButton = ""; // Track the selected button
  List<CardData> cardDataList = addCardDataList_data;

  List<Transaction> transactions = transactions_data;
  final Map<String, IconData> iconMapping = iconMapping_data;
  bool isSpendViewSelected = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Overview()));
    } else if (index == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Savings()));
    }
  }

  void _navigateToScreen(BuildContext context, String cardName) {
    setState(() {
      _selectedButton = cardName; // Update the selected button
    });

    switch (cardName) {
      case "Add Income":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddIncome()),
        );
        break;
      case "Add Expense":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddExpense()),
        );
        break;
      default:
        print("Unknown card selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(
        title: "Add",
        titleAlignment: MainAxisAlignment.center,
        showImage: false,
        showBackButton: true,
        backgroundColor: DarkMode.neutralColor,
      ),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Add()),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      backgroundColor: DarkMode.backgroundColor,
      body: Stack(
        children: [
          addIncomeExpenseButtons(),
          DraggableScrollableSheet(
            initialChildSize: 0.75, // Start at 50% of the screen height
            minChildSize: 0.75, // Minimum size when collapsed
            maxChildSize: 1, // Maximum size when fully expanded
            builder: (context, scrollController) {
              return SpendList(scrollController: scrollController);
            },
          ),
        ],
      ),
    );
  }

  Widget addIncomeExpenseButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 60,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.add,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () {
              _navigateToScreen(context, "Add Expense");
            },
            child: Container(
              width: 130,
              height: 90,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _selectedButton == "Add Expense"
                    ? DarkMode.buttonColor
                    : DarkMode.neutralColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  if (_selectedButton == "Add Expense")
                    BoxShadow(
                      color: DarkMode.buttonColor,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 26,
                    color: Colors.white,
                  ),
                  Text(
                    "Add Expense",
                    style: TextStyle(
                      color: const Color.fromARGB(203, 255, 255, 255),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _navigateToScreen(context, "Add Income");
            },
            child: Container(
              width: 130,
              height: 90,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _selectedButton == "Add Income"
                    ? DarkMode.buttonColor
                    : DarkMode.neutralColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  if (_selectedButton == "Add Income")
                    BoxShadow(
                      color: DarkMode.buttonColor,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 26,
                    color: Colors.white,
                  ),
                  Text(
                    "Add Income",
                    style: TextStyle(
                      color: const Color.fromARGB(203, 255, 255, 255),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget SpendList({required ScrollController scrollController}) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: DarkMode.neutralColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Latest Entries",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("this is three point button");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DarkMode.neutralColor,
                    fixedSize: const Size(40, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 0.7,
                      ),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          transactions.isEmpty
              ? Center(
                  child: Text(
                    "No transactions available.",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    controller: scrollController, // Attach scroll controller
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      final icon =
                          iconMapping[transaction.type] ?? Icons.help_outline;

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
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        title: Text(transaction.type,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20)),
                        subtitle: Text(transaction.date,
                            style: const TextStyle(color: Colors.white70)),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                '${transaction.amount} + VAT ${transaction.vat}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18)),
                            Text(transaction.method,
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 15)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
