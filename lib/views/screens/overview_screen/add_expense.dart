import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expensy/Data/categoriesData.dart'; // categoriesList_data is imported here
import 'package:expensy/views/screens/overview_screen/overview.dart';
import 'package:expensy/views/screens/savings_screen/savings.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/calender.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  int _selectedIndex = 0;
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = ""; // Updated for clarity

  final TextEditingController _expenseTitleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _newCategoryController =
      TextEditingController(); // Controller for new category

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

  void _updateSelectedDate(String formattedDate) {
    setState(() {
      _selectedDate = DateFormat('dd MM yyyy').parse(formattedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(
        title: "Add Expense",
        titleAlignment: MainAxisAlignment.center,
        showImage: false,
        showBackButton: true,
        backgroundColor: DarkMode.neutralColor,
      ),
      backgroundColor: DarkMode.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: DarkMode.neutralColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(30),
              child: CalendarWidget(
                selectedDate: _selectedDate,
                onDateSelected: _updateSelectedDate,
              ),
            ),
            ExpenseForm(),
            ExpanseCategories(),
            Padding(
              padding: const EdgeInsets.all(
                  8.0), // Outer padding (margin-like effect)
              child: Container(
                margin: EdgeInsetsDirectional.only(
                    bottom:
                        16), // Outer margin around the button (distance from other widgets)
                child: ElevatedButton(
                  onPressed: () {
                    final expenseTitle = _expenseTitleController.text;
                    final amount = _amountController.text;

                    // Process data
                    print('Expense Title: $expenseTitle');
                    print('Amount: $amount');
                    print('Date: $_selectedDate');
                    print('Selected Category: $_selectedCategory');
                  },
                  child: Text(
                    'ADD EXPENSE',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(DarkMode.buttonColor),
                    minimumSize: MaterialStateProperty.all(Size(325, 50)),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0)), // Padding inside the button
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ExpanseCategories() {
    final List<String> categoriesListData = categoriesList_data;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text("Expense Category"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
          child: Wrap(
            spacing: 16, // Horizontal spacing
            runSpacing: 16, // Vertical spacing
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Show dialog to add new category
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Add New Category"),
                        content: TextField(
                          controller: _newCategoryController,
                          decoration:
                              InputDecoration(hintText: "Enter category name"),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              final newCategory = _newCategoryController.text;
                              if (newCategory.isNotEmpty &&
                                  !categoriesListData.contains(newCategory)) {
                                setState(() {
                                  categoriesListData.add(newCategory);
                                });
                                _newCategoryController.clear();
                                Navigator.pop(context);
                              } else {
                                // Show a message or validation feedback
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Category already exists or is empty!"),
                                  ),
                                );
                              }
                            },
                            child: Text("Add"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  width: 60,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 41, 52, 61),
                    border: Border.all(color: Colors.grey, width: 0.8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.grey,
                  ),
                ),
              ),
              // Dynamic buttons for existing categories
              ...categoriesListData.map((category) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category; // Use descriptive name
                    });
                    print("Selected Category: $category");
                  },
                  child: Container(
                    width: 120,
                    height: 80,
                    decoration: BoxDecoration(
                      color: _selectedCategory == category
                          ? DarkMode.buttonColor
                          : DarkMode.neutralColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        if (_selectedCategory == category)
                          BoxShadow(
                            color: DarkMode.buttonColor,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: Color.fromARGB(203, 255, 255, 255),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget ExpenseForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(start: 15, end: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Expense Title"),
                SizedBox(height: 10),
                TextField(
                  controller: _expenseTitleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: DarkMode.neutralColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Amount"),
                SizedBox(height: 10),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: DarkMode.neutralColor,
                    suffixText: '\$',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
