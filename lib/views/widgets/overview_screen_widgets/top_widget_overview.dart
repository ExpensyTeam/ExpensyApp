import 'package:expensy/Data/cardData.dart';
import 'package:expensy/utils/top_view_card.dart';
import 'package:expensy/views/screens/overview_screen/investement.dart';
import 'package:expensy/views/screens/overview_screen/total_expenses.dart';
import 'package:expensy/views/screens/overview_screen/total_income.dart';
import 'package:expensy/views/screens/savings_screen/savings.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:flutter/material.dart';

// Main Overview Screen
class TopOverview extends StatefulWidget {
  @override
  _TopOverviewState createState() => _TopOverviewState();
}

class _TopOverviewState extends State<TopOverview> {
  int _selectedIndex = -1;
  List<CardData> cardDataList = cardDataList_data;

  void _navigateToScreen(BuildContext context, String cardName) {
    switch (cardName) {
      case "Total Income":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TotalIncome()),
        );
        break;
      case "Total Expenses":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TotalExpensesScreen()),
        );
        break;
      case "Total Saving":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Savings()),
        );
        break;
      case "Investments":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Investements()),
        );
        break;
      default:
        print("Unknown card selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 7),
      child: SizedBox(
        height: 150,
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
                  color:
                      isSelected ? DarkMode.buttonColor : DarkMode.neutralColor,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      cardData.amount,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
    );
  }
}
