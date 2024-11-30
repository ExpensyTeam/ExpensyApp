import 'package:expensy/views/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting

class CalendarWidget extends StatefulWidget {
  final DateTime selectedDate;
  final Function(String) onDateSelected; // Change to String for formatted date

  const CalendarWidget({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;

          // Format the selected date
          String formattedDate = DateFormat('dd MM yyyy').format(_selectedDay!);
          print(formattedDate);

          // Pass the formatted date to the callback
          widget.onDateSelected(formattedDate);
        });
      },
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      calendarStyle: CalendarStyle(
        defaultTextStyle: TextStyle(color: Colors.white, fontSize: 14.0),
        weekendTextStyle: TextStyle(color: Colors.white, fontSize: 14.0),
        todayDecoration: BoxDecoration(
          color: DarkMode.buttonColor,
          borderRadius: BorderRadius.circular(12),
        ),
        selectedDecoration: BoxDecoration(
          color: DarkMode.buttonColor,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle(color: Colors.white, fontSize: 14.0),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 14.0),
        formatButtonDecoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        leftChevronIcon: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(Icons.chevron_left, color: Colors.white),
        ),
        rightChevronIcon: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(Icons.chevron_right, color: Colors.white),
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.white, fontSize: 14.0),
        weekendStyle: TextStyle(color: Colors.white, fontSize: 14.0),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, events) => Container(
          margin: EdgeInsets.all(4.0),
          child: Center(
            child: Text(
              date.day.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
