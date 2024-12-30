import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_learning/pantry/custom_widgets/date/date_widget.dart';

class DateSelector extends StatelessWidget {
  final Function(DateTime)? onDateTapped;
  final int daysToGenerate;
  final int selectedIndex;
  const DateSelector({
    super.key,
    this.onDateTapped,
    required this.daysToGenerate,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime startDate = DateTime.now().subtract(Duration(days: 2));
    final dates = List<DateTime>.generate(
      daysToGenerate,
      (index) => startDate.add(Duration(days: index)),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: dates.asMap().entries.map((entry) {
        final index = entry.key;
        final date = entry.value;
        final isSelected = index == selectedIndex;
        final dayOfWeek = DateFormat.E().format(date);
        final day = DateFormat.d().format(date);
        final month = DateFormat.MMM().format(date).toUpperCase();
        return GestureDetector(
          onTap: () {
            if (onDateTapped != null) {
              onDateTapped!(date);
              print("date: $date");
            }
          },
          child: DateWidget(
              dayOfWeek: dayOfWeek,
              day: day,
              month: month,
              isSelected: isSelected),
        );
      }).toList(),
    );
  }
}
