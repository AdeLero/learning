import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final Function onDaySelected;
  Calendar({required this.onDaySelected});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: today,
      firstDay: DateTime(1990),
      lastDay: DateTime(2200),
      selectedDayPredicate: (day) {
        return isSameDay(today, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        today = selectedDay;
        today = focusedDay;
        widget.onDaySelected(today);
      },
      headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextFormatter: (date, locale) {
            final month = DateFormat.MMM().format(date);
            final year = DateFormat.y().format(date);
            return '$month $year';
          }
      ),
    );
  }
}