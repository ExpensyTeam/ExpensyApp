/* import 'dart:ui';
import 'package:expensy/views/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:table_calendar/table_calendar.dart'; // Ensure this is imported for TableCalendar
import 'package:expensy/views/widgets/app_bar.dart';
// Ensure you have the CalendarWidget available for use
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/calender.dart';

class AddGoalPage extends StatefulWidget {
  @override
  _AddGoalPageState createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  String? _selectedContributionType = 'Yearly';
  DateTime _selectedDate = DateTime.now(); // Track selected date
  final List<String> _contributionOptions = [
    'Yearly',
    'Monthly',
    'Weekly',
    'Daily'
  ];

  final TextEditingController _goalTitleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _newCategoryController = TextEditingController();

  // Update selected date with formatted date
  void _updateSelectedDate(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate; // Update selected date
    });
  }

  @override
  Widget build(BuildContext context) {
    // Format date to show as "12 February 2024"
    final formattedDate = DateFormat('d MMMM yyyy').format(_selectedDate);

    return Scaffold(
      appBar: CustomizedAppBar(
        title: "Goals",
        titleAlignment: MainAxisAlignment.center,
        showImage: false,
        showBackButton: true,
        backgroundColor: DarkMode.neutralColor,
      ),
      backgroundColor: DarkMode.neutralColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Calendar Widget with Background Color
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[850], // Apply background color here
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(30),
              child: TableCalendar(
                focusedDay: _selectedDate,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                selectedDayPredicate: (day) {
                  return _selectedDate != null && isSameDay(_selectedDate, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Goal Title Field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Goal Title',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(height: 10),
                        TextField(
                          controller: _goalTitleController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[800],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: 'Enter goal title',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Amount Field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amount', style: TextStyle(color: Colors.white)),
                        SizedBox(height: 10),
                        TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[800],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: 'Enter amount',
                            suffixText: '\$',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Contribution Type Field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      onTap: () {
                        // Open dropdown for contribution type
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedContributionType ??
                                  'Select Contribution Type',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(Icons.arrow_drop_down, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Deadline Date Field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      onTap: () {
                        // Open calendar dialog
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 5.0, sigmaY: 5.0),
                                  child: AlertDialog(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    content: Column(
                                      children: [
                                        TableCalendar(
                                          focusedDay: _selectedDate,
                                          firstDay: DateTime.utc(2020, 1, 1),
                                          lastDay: DateTime.utc(2030, 12, 31),
                                          selectedDayPredicate: (day) {
                                            return _selectedDate != null &&
                                                isSameDay(_selectedDate, day);
                                          },
                                          onDaySelected:
                                              (selectedDay, focusedDay) {
                                            setState(() {
                                              _selectedDate = selectedDay;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(text: formattedDate),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[800],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          hintText: 'Select deadline',
                          suffixIcon:
                              Icon(Icons.calendar_today, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add Goal button action
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  minimumSize: MaterialStateProperty.all(Size(325, 50)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0))),
                ),
                child: Text('ADD GOAL',
                    style: TextStyle(color: Colors.white, fontSize: 17)),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
 */
/* 
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:expensy/views/widgets/app_bar.dart';
import 'package:table_calendar/table_calendar.dart'; // Import TableCalendar
import 'package:intl/intl.dart'; // Import intl for DateFormat

class AddGoalPage extends StatefulWidget {
  @override
  _AddGoalPageState createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  String? _selectedContributionType = 'Yearly';
  String? _selectedDate; // Store the selected date
  final List<String> _contributionOptions = [
    'Yearly',
    'Monthly',
    'Weekly',
    'Daily'
  ];

  // Focus nodes for border change
  final _goalTitleFocus = FocusNode();
  final _amountFocus = FocusNode();

  // Focused calendar date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedCalendarDate;

  // Show dropdown with larger box size for contribution type
  void _showContributionTypeSelector() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // Dialog width
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Blur effect
              child: AlertDialog(
                backgroundColor: Colors.black.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                contentPadding: EdgeInsets.zero,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _contributionOptions.map((option) {
                    return ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      title: Text(
                        option,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18, // Standard font size
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedContributionType = option;
                        });
                        Navigator.of(context).pop();
                      },
                      trailing: option == _selectedContributionType
                          ? Icon(Icons.check_circle,
                              color: Colors.blue, size: 28)
                          : null,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Show the Table Calendar with blurred background
  void _showCalendar() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // Dialog width
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Blur effect
              child: AlertDialog(
                backgroundColor: Colors.black.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                contentPadding: EdgeInsets.zero,
                content: Column(
                  children: [
                    TableCalendar(
                      focusedDay: _focusedDay,
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      selectedDayPredicate: (day) {
                        return _selectedCalendarDate != null &&
                            isSameDay(_selectedCalendarDate, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedCalendarDate = selectedDay;
                          _focusedDay = focusedDay; // Update focused day
                          _selectedDate = DateFormat('MMMM d, yyyy')
                              .format(selectedDay); // Format date
                        });
                        Navigator.of(context).pop(); // Close the calendar
                      },
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(color: Colors.white),
                      ),
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        todayTextStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _goalTitleFocus.dispose();
    _amountFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(
        title: "Goals",
        titleAlignment: MainAxisAlignment.center,
        showImage: false,
        showBackButton: true,
        backgroundColor: DarkMode.neutralColor,
      ),
      backgroundColor: DarkMode.neutralColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Goal Title Field
            Text('Goal Title',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            TextField(
              focusNode: _goalTitleFocus,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.lightBlue, width: 2),
                ),
                hintText: 'Enter goal title',
              ),
            ),
            SizedBox(height: 16),

            // Amount Field
            Text('Amount', style: TextStyle(color: Colors.white, fontSize: 16)),
            TextField(
              focusNode: _amountFocus,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.lightBlue, width: 2),
                ),
                hintText: 'Enter amount',
                suffixText: '\$',
              ),
            ),
            SizedBox(height: 16),

            // Contribution Type Field
            Text('Contribution Type',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            GestureDetector(
              onTap: _showContributionTypeSelector,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedContributionType ?? 'Select Contribution Type',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Deadline Field
            Text('Deadline',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            GestureDetector(
              onTap: _showCalendar, // Open the calendar on tap
              child: TextField(
                readOnly: true,
                controller: TextEditingController(
                    text: _selectedDate), // Ensure date is displayed
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade900,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: _selectedDate ?? 'Select deadline',
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.white),
                ),
              ),
            ),

            Expanded(child: Container()),

            // Add Goal Button with Glow Effect
            Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 15,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add Goal button press
                    },
                    child: Text('ADD GOAL'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16), // Bottom padding
          ],
        ),
      ),
    );
  }
}
 */
/* 
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:table_calendar/table_calendar.dart'; // Ensure this is imported for TableCalendar
import 'package:expensy/views/widgets/app_bar.dart';
// Ensure you have the CalendarWidget available for use
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/calender.dart';

class AddGoalPage extends StatefulWidget {
  @override
  _AddGoalPageState createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  String? _selectedContributionType = 'Yearly';
  DateTime _selectedDate = DateTime.now(); // Track selected date
  final List<String> _contributionOptions = [
    'Yearly',
    'Monthly',
    'Weekly',
    'Daily'
  ];

  final TextEditingController _goalTitleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _newCategoryController = TextEditingController();

  // Update selected date with formatted date
  void _updateSelectedDate(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate; // Update selected date
    });
  }

  // Show dropdown for contribution type
  void _showContributionTypeSelector() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // Dialog width
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Blur effect
              child: AlertDialog(
                backgroundColor: Colors.black.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                contentPadding: EdgeInsets.zero,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _contributionOptions.map((option) {
                    return ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      title: Text(
                        option,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18, // Standard font size
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedContributionType = option;
                        });
                        Navigator.of(context).pop();
                      },
                      trailing: option == _selectedContributionType
                          ? Icon(Icons.check_circle,
                              color: Colors.blue, size: 28)
                          : null,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Format date to show as "12 February 2024"
    final formattedDate = DateFormat('d MMMM yyyy').format(_selectedDate);

    return Scaffold(
      appBar: CustomizedAppBar(
        title: "Goals",
        titleAlignment: MainAxisAlignment.center,
        showImage: false,
        showBackButton: true,
        backgroundColor: DarkMode.neutralColor,
      ),
      backgroundColor: DarkMode.neutralColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Calendar Widget with Background Color
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[850], // Apply background color here
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(30),
              child: TableCalendar(
                focusedDay: _selectedDate,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                selectedDayPredicate: (day) {
                  return _selectedDate != null && isSameDay(_selectedDate, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Goal Title Field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Goal Title',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(height: 10),
                        TextField(
                          controller: _goalTitleController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[800],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: 'Enter goal title',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Amount Field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amount', style: TextStyle(color: Colors.white)),
                        SizedBox(height: 10),
                        TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[800],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: 'Enter amount',
                            suffixText: '\$',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Contribution Type Field with Dialog
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      onTap: _showContributionTypeSelector,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedContributionType ??
                                  'Select Contribution Type',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(Icons.arrow_drop_down, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Deadline Date Field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      onTap: () {
                        // Open calendar dialog
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 5.0, sigmaY: 5.0),
                                  child: AlertDialog(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    content: Column(
                                      children: [
                                        TableCalendar(
                                          focusedDay: _selectedDate,
                                          firstDay: DateTime.utc(2020, 1, 1),
                                          lastDay: DateTime.utc(2030, 12, 31),
                                          selectedDayPredicate: (day) {
                                            return _selectedDate != null &&
                                                isSameDay(_selectedDate, day);
                                          },
                                          onDaySelected:
                                              (selectedDay, focusedDay) {
                                            setState(() {
                                              _selectedDate = selectedDay;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(text: formattedDate),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[800],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          hintText: 'Select deadline',
                          suffixIcon:
                              Icon(Icons.calendar_today, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add Goal button action
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  minimumSize: MaterialStateProperty.all(Size(325, 50)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0))),
                ),
                child: Text('ADD GOAL',
                    style: TextStyle(color: Colors.white, fontSize: 17)),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
 */
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:expensy/views/themes/colors.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:table_calendar/table_calendar.dart'; // Ensure this is imported for TableCalendar
import 'package:expensy/views/widgets/app_bar.dart';
// Ensure you have the CalendarWidget available for use
import 'package:expensy/views/widgets/total_expenses_screen_widgets.dart/calender.dart';

class AddGoalPage extends StatefulWidget {
  @override
  _AddGoalPageState createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  String? _selectedContributionType = 'Yearly';
  DateTime _selectedDate = DateTime.now(); // Track selected date
  final List<String> _contributionOptions = [
    'Yearly',
    'Monthly',
    'Weekly',
    'Daily'
  ];

  final TextEditingController _goalTitleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _newCategoryController = TextEditingController();

  // Update selected date with formatted date
  void _updateSelectedDate(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate; // Update selected date
    });
  }

  // Show dropdown for contribution type
  void _showContributionTypeSelector() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // Dialog width
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Blur effect
              child: AlertDialog(
                backgroundColor: Colors.black.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                contentPadding: EdgeInsets.zero,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _contributionOptions.map((option) {
                    return ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      title: Text(
                        option,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18, // Standard font size
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedContributionType = option;
                        });
                        Navigator.of(context).pop();
                      },
                      trailing: option == _selectedContributionType
                          ? Icon(Icons.check_circle,
                              color: Colors.blue, size: 28)
                          : null,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Format date to show as "12 February 2024"
    final formattedDate = DateFormat('d MMMM yyyy').format(_selectedDate);

    return Scaffold(
      appBar: CustomizedAppBar(
        title: "Goals",
        titleAlignment: MainAxisAlignment.center,
        showImage: false,
        showBackButton: true,
        backgroundColor: DarkMode.neutralColor,
      ),
      backgroundColor: DarkMode.neutralColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16), // You can adjust the height as needed
            // Goal Title Field
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Goal Title', style: TextStyle(color: Colors.white)),
                  SizedBox(height: 10),
                  TextField(
                    controller: _goalTitleController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: 'Enter goal title',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Amount Field
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Amount', style: TextStyle(color: Colors.white)),
                  SizedBox(height: 10),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: 'Enter amount',
                      suffixText: '\$',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Contribution Type Field with Dialog
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Contribution Type',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: _showContributionTypeSelector,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _selectedContributionType ??
                                    'Select Contribution Type',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(Icons.arrow_drop_down, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ])),
            SizedBox(height: 16),

            // Deadline Date Field
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Contribution Type',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          // Open calendar dialog
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 5.0, sigmaY: 5.0),
                                    child: AlertDialog(
                                      backgroundColor:
                                          Colors.black.withOpacity(0.8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                      content: Column(
                                        children: [
                                          Container(
                                            color: const Color.fromARGB(
                                                255, 0, 132, 255),
                                            child: TableCalendar(
                                              focusedDay: _selectedDate,
                                              firstDay:
                                                  DateTime.utc(2020, 1, 1),
                                              lastDay:
                                                  DateTime.utc(2030, 12, 31),
                                              selectedDayPredicate: (day) {
                                                return _selectedDate != null &&
                                                    isSameDay(
                                                        _selectedDate, day);
                                              },
                                              onDaySelected:
                                                  (selectedDay, focusedDay) {
                                                setState(() {
                                                  _selectedDate = selectedDay;
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: TextField(
                          readOnly: true,
                          controller:
                              TextEditingController(text: formattedDate),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[800],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: 'Select deadline',
                            suffixIcon:
                                Icon(Icons.calendar_today, color: Colors.white),
                          ),
                        ),
                      ),
                    ])),

            // Place the calendar directly under the "Deadline" input
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[850], // Apply background color here
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(10),
                child: TableCalendar(
                  focusedDay: _selectedDate,
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  selectedDayPredicate: (day) {
                    return _selectedDate != null &&
                        isSameDay(_selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDate = selectedDay;
                    });
                  },
                ),
              ),
            ),

            // Add Goal Button
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add Goal button action
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  minimumSize: MaterialStateProperty.all(Size(325, 50)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0))),
                ),
                child: Text('ADD GOAL',
                    style: TextStyle(color: Colors.white, fontSize: 17)),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
