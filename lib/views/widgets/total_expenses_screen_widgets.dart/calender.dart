import 'package:expensy/views/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

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
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.white, fontSize: 14.0),
        weekendStyle: TextStyle(color: Colors.white, fontSize: 14.0),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, events) => Container(
          margin: EdgeInsets.all(4.0),
          // decoration: BoxDecoration(
          //   color: DarkMode.primaryColor,
          //   borderRadius: BorderRadius.circular(6.0),
          // ),
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
