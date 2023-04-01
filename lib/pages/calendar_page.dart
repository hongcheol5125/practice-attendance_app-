import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/event.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Map<DateTime, List<Event>>? selectedEvents;
  CalendarFormat format = CalendarFormat.month; // 2주씩 볼 수 있게 하는 코드
  DateTime _selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    selectedEvents = {};
    // TODO: implement initState
    scheduleFromFirestore();
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    DateTime _date = DateTime(date.year, date.month, date.day);
    return selectedEvents![_date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '일정표',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.orange,
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
            TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              //on~~ 은 "~~ 했을 때 뭐를 실행시켜라" 라는 뜻!
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
              eventLoader: _getEventsfromDay,
            ),
            Expanded(
            child: ListView(
              children: [
                ..._getEventsfromDay(_selectedDay) //key(DateTime)
                    .map((Event event) => ListTile(title: Text(event.title))),
              ],
            ),
          ),
          ],
        ));
  }

  Future scheduleFromFirestore() async {
    await FirebaseFirestore.instance.collection('myevents').get().then((value) {
      List<DocumentSnapshot> testValue = value.docs;
      testValue.forEach((element) {
        Map<String, dynamic> dbData = element.data() as Map<String, dynamic>;
        print(dbData['date'].runtimeType);

        String stringDate = dbData['date'] as String;

        DateTime selectedDay;

        // int.parse()는 숫자로만 된 String을 int로 바꿔줌
        int year = int.parse(stringDate.substring(0, 4));
        int month = int.parse(stringDate.substring(5, 7));
        int day = int.parse(stringDate.substring(8, 10));
        selectedDay = DateTime(year, month, day);

        if (selectedEvents![selectedDay] != null) {
          selectedEvents![selectedDay]?.add(Event(title: dbData['event']));
        } else {
          selectedEvents![selectedDay] = [Event(title: dbData['event'])];
        }
      });

      setState(() {});
    });
  }
}
