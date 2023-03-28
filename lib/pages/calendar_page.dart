import 'package:attendance_app_final/model/myevents.dart';
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
  CalendarFormat format = CalendarFormat.month;
  DateTime _selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime _focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents![date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  Future EnterEventAtFirebase( MyEvents myEvents) async {
    await FirebaseFirestore.instance
        .collection('myevents')
        .doc(myEvents.event)
        .set(myEvents.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '일 정 표',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          TableCalendar(
            firstDay: DateTime.utc(2020, 01, 01),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: DateTime.now(),
            // 2주씩 보게 하는 코드
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            // 시작 요일 지정!
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
          // event 입력하면 달력 아래에 뜨게 만드는 코드(1)
          ..._getEventsfromDay(_selectedDay)
              .map((Event event) => ListTile(title: Text(event.title))),
          FloatingActionButton.extended(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Add Event'),
                content: TextField(
                  controller: _eventController,
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel')),
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () async{
                      if (_eventController.text.isEmpty) {
                      } else {
                        if (selectedEvents![_selectedDay] != null) {
                          selectedEvents![_selectedDay]
                              ?.add(Event(title: _eventController.text));
                        } else {
                          selectedEvents![_selectedDay] = [
                            Event(title: _eventController.text)
                          ];
                          MyEvents _myEvents = MyEvents(
                            event: _eventController.text,
                            date: DateTime.now(),
                          );
                          await EnterEventAtFirebase(_myEvents);
                        }
                        Navigator.pop(context);
                        _eventController.clear();
                        setState(() {});
                        return;
                      }
                    },
                  ),
                ],
              ),
            ),
            label: Text('Add Event'),
            icon: Icon(Icons.add),
          ),
          BottomAppBar(child: Text('단어게임 / QR코드 등 들어가는 버튼 만들거야!')),
        ],
      ),
    );
  }
}
