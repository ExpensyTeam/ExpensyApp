import 'package:flutter/material.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const CustomCalendar({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime _currentMonth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(widget.selectedDate.year, widget.selectedDate.month);
    _selectedDate = widget.selectedDate;
  }

  List<String> get _weekDays => ['Mo', 'Tu', 'We', 'Th', 'Fri', 'Sa', 'Su'];

  List<Widget> _buildCalendarDays() {
    List<Widget> dayWidgets = [];
    
    // First day of the month
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    // Days from previous month
    var weekDay = firstDay.weekday - 1;
    final prevMonthDays = List.generate(weekDay, (index) {
      final day = firstDay.subtract(Duration(days: weekDay - index));
      return _buildDayCell(day, isCurrentMonth: false);
    });
    
    // Days of current month
    final daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final currentMonthDays = List.generate(daysInMonth, (index) {
      final day = DateTime(_currentMonth.year, _currentMonth.month, index + 1);
      return _buildDayCell(day, isCurrentMonth: true);
    });
    
    // Days from next month
    final remainingDays = 42 - prevMonthDays.length - currentMonthDays.length;
    final nextMonthDays = List.generate(remainingDays, (index) {
      final day = DateTime(_currentMonth.year, _currentMonth.month + 1, index + 1);
      return _buildDayCell(day, isCurrentMonth: false);
    });
    
    dayWidgets.addAll([...prevMonthDays, ...currentMonthDays, ...nextMonthDays]);
    return dayWidgets;
  }

  Widget _buildDayCell(DateTime date, {required bool isCurrentMonth}) {
    final isSelected = date.year == _selectedDate.year &&
        date.month == _selectedDate.month &&
        date.day == _selectedDate.day;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDate = date;
        });
        widget.onDateSelected(date);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle(
              color: isCurrentMonth ? 
                (isSelected ? Colors.white : Colors.white.withOpacity(0.87)) :
                Colors.white.withOpacity(0.38),
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.38)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.chevron_left, color: Colors.white, size: 24),
                ),
                onPressed: () {
                  setState(() {
                    _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
                  });
                },
              ),
              Text(
                '${_currentMonth.year} - ${_currentMonth.month}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.38)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.chevron_right, color: Colors.white, size: 24),
                ),
                onPressed: () {
                  setState(() {
                    _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _weekDays.map((day) => Text(
              day,
              style: TextStyle(color: Colors.white.withOpacity(0.87), fontSize: 14),
            )).toList(),
          ),
          const SizedBox(height: 8),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: _buildCalendarDays(),
          ),
        ],
      ),
    );
  }
}