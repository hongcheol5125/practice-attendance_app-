import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // 날짜 선택 처리 인자는 onDaySelected, selectedDayPredicate 로 할 수 있다.
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('일정표'),
          backgroundColor: Colors.orange,
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
            TableCalendar(
              locale: 'ko_KR',
              firstDay: DateTime.utc(2021, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: focusedDay,
              onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                setState(() {
                  this.selectedDay = selectedDay;
                  this.focusedDay = focusedDay;
                });
              },
              selectedDayPredicate: (DateTime day) {
                return isSameDay(selectedDay, day);
              },
            ),
          ],
        ));
  }
}
