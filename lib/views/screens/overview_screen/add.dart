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
  List<CardData> cardDataList = addCardDataList_data;

  List<Transaction> transactions = transactions_data;
  final Map<String, IconData> iconMapping = iconMapping_data;
  bool isSpendViewSelected = true; // Track the currently selected vie

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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 7),
              child: SizedBox(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: cardDataList.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedIndex == index;
                    final cardData = cardDataList[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = isSelected ? -1 : index;
                        });

                        // Navigate to the appropriate screen
                        _navigateToScreen(context, cardData.name);
                      },
                      child: Container(
                        width: 130,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? DarkMode.buttonColor
                              : DarkMode.neutralColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            if (isSelected)
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
                            Icon(
                              cardData.icon,
                              size: 26,
                              color: Colors.white,
                            ),
                            Text(
                              cardData.name,
                              style: TextStyle(
                                color: const Color.fromARGB(203, 255, 255, 255),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 20);
                  },
                ),
              ),
            ),
            SpendList()
          ],
        ));
  }

  Widget SpendList() {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.56,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: DarkMode.neutralColor,
          borderRadius: BorderRadius.only(
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
                    onPressed: () => {
                      print("this is three point button")
                    }, // Define your onPressed logic
                    style: ElevatedButton.styleFrom(
                      backgroundColor: DarkMode.neutralColor,
                      fixedSize: const Size(40, 40), // Adjusted for usability
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
            transactions.isEmpty // Add a check for empty transactions
                ? Center(
                    child: Text(
                      "No transactions available.",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
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
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust radius as needed
                            ),
                            child: Icon(
                              icon, // Use the corresponding icon for the transaction type
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          title: Text(transaction.type,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          subtitle: Text(transaction.date,
                              style: TextStyle(color: Colors.white70)),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  '${transaction.amount} + VAT ${transaction.vat}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              Text(transaction.method,
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 15)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
