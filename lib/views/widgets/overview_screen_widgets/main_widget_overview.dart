import 'package:expensy/Data/iconMapping.dart';
import 'package:expensy/Data/transactions.dart';
import 'package:expensy/utils/transaction.dart';
import 'package:expensy/views/screens/budget_stats_screen/budget_stats.dart';
import 'package:expensy/views/screens/savings_screen/savings.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainOverview extends StatefulWidget {
  final ScrollController scrollController;

  const MainOverview({required this.scrollController});

  @override
  _MainOverviewState createState() => _MainOverviewState();
}

class _MainOverviewState extends State<MainOverview> {
  String _selectedButton = "Saving"; // Default selection

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: DarkMode.neutralColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 14),
          BuildTextButtons(
            selectedButton: _selectedButton,
            onButtonPressed: (label) {
              setState(() {
                _selectedButton = label; // Update the selected button
              });
            },
          ),
          BuildProgressBar(selectedButton: _selectedButton),
          Expanded(
            child: MainOverviewList(
              scrollController: widget.scrollController,
            ),
          ),
        ],
      ),
    );
  }
}

class BuildTextButtons extends StatelessWidget {
  final String selectedButton;
  final Function(String) onButtonPressed;

  const BuildTextButtons({
    required this.selectedButton,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.28;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width,
            child: _buildButtonText("Saving", Icons.add, Savings()),
          ),
          SizedBox(
            width: width,
            child: _buildButtonText(
                "Reminder", Icons.notifications_none, Savings()),
          ),
          SizedBox(
            width: width,
            child: _buildButtonText(
                "Budget", Icons.account_balance_wallet_outlined, BudgetStats()),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonText(String label, IconData icon, Widget targetScreen) {
    final bool isSelected = label == selectedButton;

    return Container(
      decoration: isSelected
          ? BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: DarkMode.buttonColor.withOpacity(0.5),
                  blurRadius: 12,
                  offset: Offset(0, 3),
                ),
              ],
            )
          : null,
      child: Builder(
        builder: (BuildContext context) {
          // Builder widget provides the context
          return ElevatedButton(
            onPressed: () {
              onButtonPressed(label); // Update the state

              // Now we have access to context here
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => targetScreen),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected
                  ? DarkMode.buttonColor
                  : Color.fromRGBO(16, 29, 39, 1),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? DarkMode.iconBackground2
                          : DarkMode.iconBackground,
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: DarkMode.buttonColor.withOpacity(0.7),
                                blurRadius: 3,
                                offset: Offset(0, 3),
                              ),
                            ]
                          : [],
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BuildProgressBar extends StatelessWidget {
  final String selectedButton;

  const BuildProgressBar({required this.selectedButton});

  Widget progressBarSegment({double margin = 0, required String label}) {
    final bool isSelected = label == selectedButton;

    return Container(
      width: 17,
      height: 6,
      margin: EdgeInsets.symmetric(horizontal: margin),
      decoration: BoxDecoration(
        color: isSelected ? DarkMode.buttonColor : DarkMode.iconBackground,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          progressBarSegment(margin: 0, label: "Saving"),
          progressBarSegment(margin: 10, label: "Reminder"),
          progressBarSegment(margin: 0, label: "Budget"),
        ],
      ),
    );
  }
}

class MainOverviewList extends StatefulWidget {
  final ScrollController scrollController;

  const MainOverviewList({required this.scrollController});

  @override
  _MainOverviewListState createState() => _MainOverviewListState();
}

class _MainOverviewListState extends State<MainOverviewList> {
  List<Transaction> transactions = transactions_data;

  final Map<String, IconData> iconMapping = iconMapping_data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Latest Entries",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              ElevatedButton(
                onPressed: () => print("this is three point button"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: DarkMode.neutralColor,
                  fixedSize: const Size(10, 10),
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
        SizedBox(height: 15),
        Expanded(
          child: ListView.builder(
            controller:
                widget.scrollController, // Use the passed scrollController
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              final icon =
                  iconMapping[transaction.type] ?? Icons.attach_money_rounded;

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
