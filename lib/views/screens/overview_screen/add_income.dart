// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:expensy/Data/categoriesData.dart'; // categoriesList_data is imported here
// import 'package:expensy/views/screens/overview_screen/overview.dart';
// import 'package:expensy/views/screens/savings_screen/savings.dart';
// import 'package:expensy/views/themes/colors.dart';
// import 'package:expensy/views/widgets/app_bar.dart';
// import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/calender.dart';

// class AddIncome extends StatefulWidget {
//   const AddIncome({Key? key}) : super(key: key);

//   @override
//   _AddIncomeState createState() => _AddIncomeState();
// }

// class _AddIncomeState extends State<AddIncome> {
//   int _selectedIndex = 0;
//   DateTime _selectedDate = DateTime.now();
//   String _selectedCategory = ""; // Updated for clarity

//   final TextEditingController _incomeTitleController = TextEditingController();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _newCategoryController =
//       TextEditingController(); // Controller for new category

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     if (index == 0) {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const Overview()));
//     } else if (index == 1) {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => Savings()));
//     }
//   }

//   void _updateSelectedDate(String formattedDate) {
//     setState(() {
//       _selectedDate = DateFormat('dd MM yyyy').parse(formattedDate);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomizedAppBar(
//         title: "Add Income",
//         titleAlignment: MainAxisAlignment.center,
//         showImage: false,
//         showBackButton: true,
//         backgroundColor: DarkMode.neutralColor,
//       ),
//       backgroundColor: DarkMode.primaryColor,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: DarkMode.neutralColor,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               padding: EdgeInsets.all(10),
//               margin: EdgeInsets.all(30),
//               child: CalendarWidget(
//                 selectedDate: _selectedDate,
//                 onDateSelected: _updateSelectedDate,
//               ),
//             ),
//             ExpenseForm(),
//             ExpanseCategories(),
//             Padding(
//               padding: const EdgeInsets.all(
//                   8.0), // Outer padding (margin-like effect)
//               child: Container(
//                 margin: EdgeInsetsDirectional.only(
//                     bottom:
//                         16), // Outer margin around the button (distance from other widgets)
//                 child: ElevatedButton(
//                   onPressed: () {
//                     final expenseTitle = _incomeTitleController.text;
//                     final amount = _amountController.text;

//                     // Process data
//                     print('Income Title: $expenseTitle');
//                     print('Amount: $amount');
//                     print('Date: $_selectedDate');
//                     print('Selected Category: $_selectedCategory');
//                   },
//                   child: Text(
//                     'ADD Income',
//                     style: TextStyle(color: Colors.white, fontSize: 17),
//                   ),
//                   style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all(DarkMode.buttonColor),
//                     minimumSize: MaterialStateProperty.all(Size(325, 50)),
//                     padding: MaterialStateProperty.all(EdgeInsets.symmetric(
//                         vertical: 12.0,
//                         horizontal: 24.0)), // Padding inside the button
//                     shape: MaterialStateProperty.all(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget ExpanseCategories() {
//     final List<String> categoriesListData = categoriesList_data;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12),
//           child: Text("Income Category"),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
//           child: Wrap(
//             spacing: 16, // Horizontal spacing
//             runSpacing: 16, // Vertical spacing
//             crossAxisAlignment: WrapCrossAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   // Show dialog to add new category
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: Text("Add New Category"),
//                         content: TextField(
//                           controller: _newCategoryController,
//                           decoration:
//                               InputDecoration(hintText: "Enter category name"),
//                         ),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: Text("Cancel"),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               final newCategory = _newCategoryController.text;
//                               if (newCategory.isNotEmpty &&
//                                   !categoriesListData.contains(newCategory)) {
//                                 setState(() {
//                                   categoriesListData.add(newCategory);
//                                 });
//                                 _newCategoryController.clear();
//                                 Navigator.pop(context);
//                               } else {
//                                 // Show a message or validation feedback
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: Text(
//                                         "Category already exists or is empty!"),
//                                   ),
//                                 );
//                               }
//                             },
//                             child: Text("Add"),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 child: Container(
//                   width: 60,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 41, 52, 61),
//                     border: Border.all(color: Colors.grey, width: 0.8),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: const Icon(
//                     Icons.add,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//               // Dynamic buttons for existing categories
//               ...categoriesListData.map((category) {
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _selectedCategory = category; // Use descriptive name
//                     });
//                     print("Selected Category: $category");
//                   },
//                   child: Container(
//                     width: 120,
//                     height: 80,
//                     decoration: BoxDecoration(
//                       color: _selectedCategory == category
//                           ? DarkMode.buttonColor
//                           : DarkMode.neutralColor,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         if (_selectedCategory == category)
//                           BoxShadow(
//                             color: DarkMode.buttonColor,
//                             blurRadius: 8,
//                             offset: Offset(0, 4),
//                           ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         category,
//                         style: const TextStyle(
//                           color: Color.fromARGB(203, 255, 255, 255),
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget ExpenseForm() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding: EdgeInsetsDirectional.only(start: 15, end: 15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Income Title"),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: _incomeTitleController,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: DarkMode.neutralColor,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.blue,
//                         width: 2.5,
//                       ),
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Amount"),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: _amountController,
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: DarkMode.neutralColor,
//                     suffixText: '\$',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.blue,
//                         width: 2.5,
//                       ),
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:expensy/Data/transactions.dart';
import 'package:expensy/utils/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expensy/Data/categoriesData.dart'; // categoriesList_data is imported here
import 'package:expensy/views/screens/overview_screen/overview.dart';
import 'package:expensy/views/screens/savings_screen/savings.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/calender.dart';
// <<<<<<< HEAD
// =======
import 'package:expensy/views/screens/notifications_screen/notifications_screen.dart';
import 'package:expensy/views/screens/reminder_screen/reminder_screen.dart';
// >>>>>>> origin/reminder-and-notifications

class AddIncome extends StatefulWidget {
  const AddIncome({Key? key}) : super(key: key);

  @override
  _AddIncomeState createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  List<Transaction> transactions = transactions_data;
  int _selectedIndex = 0;
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = ""; // Updated for clarity

  final TextEditingController _incomeTitleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _newCategoryController =
      TextEditingController(); // Controller for new category

  // Validation checks
  bool _isValidIncomeForm() {
    return _incomeTitleController.text.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        _selectedCategory.isNotEmpty;
  }

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
// <<<<<<< HEAD
// =======
    } else if (index == 2) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const NotificationsScreen()));
    } else if (index == 3) {
      // Uncomment and add the Settings screen when available
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ReminderList()),
      );
// >>>>>>> origin/reminder-and-notifications
    }
  }

  void _updateSelectedDate(String formattedDate) {
    setState(() {
      _selectedDate = DateFormat('dd MM yyyy').parse(formattedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('d MMMM yyyy').format(_selectedDate);
    return Scaffold(
      appBar: CustomizedAppBar(
        title: "Add Income",
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
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsetsDirectional.only(bottom: 16),
                child: ElevatedButton(
                  onPressed: () {
                    final incomeTitle = _incomeTitleController.text;
                    final amountText = _amountController.text;
                    final category = _selectedCategory;

                    if (incomeTitle.isNotEmpty &&
                        amountText.isNotEmpty &&
                        category.isNotEmpty) {
                      final amount = double.tryParse(amountText);

                      if (amount != null && amount > 0) {
                        // Add the transaction to the list
                        setState(() {
                          transactions.add(Transaction(
                              type: incomeTitle,
                              amount: "+\$$amount",
                              date: formattedDate.toString(),
                              vat: "0.9%",
                              method: "card"));
                        });

                        // Clear inputs
                        _incomeTitleController.clear();
                        _amountController.clear();
                        _selectedCategory = "";

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Transaction added successfully!')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid amount!')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please fill all fields!')),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(DarkMode.buttonColor),
                    minimumSize: MaterialStateProperty.all(const Size(325, 50)),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'ADD Income',
                    style: TextStyle(color: Colors.white, fontSize: 17),
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
          child: Text("Income Category"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Category added successfully!")),
                                );
                              } else {
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
              ...categoriesListData.map((category) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
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
                Text("Income Title"),
                SizedBox(height: 10),
                TextField(
                  controller: _incomeTitleController,
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
