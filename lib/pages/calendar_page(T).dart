import 'package:attendance_app_final/model/myevents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/event.dart';

class CalendarPageTeacher extends StatefulWidget {
  const CalendarPageTeacher({super.key});

  @override
  State<CalendarPageTeacher> createState() => _CalendarPageTeacherState();
}

class _CalendarPageTeacherState extends State<CalendarPageTeacher> {
  Map<DateTime, List<Event>>? selectedEvents;
  CalendarFormat format = CalendarFormat.month;  // 2주씩 볼 수 있게 하는 코드
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
    // firebase에서 불러오는 메소드 호출!
   scheduleFromFirestore();
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    DateTime _date = DateTime(date.year, date.month,date.day);
    return selectedEvents![_date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

   enterEventAtFirebase(MyEvents myEvents)  {
     FirebaseFirestore.instance
        .collection('myevents')
        .doc(DateTime.now().toString())
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
          Expanded(
            child: ListView(children: [..._getEventsfromDay(_selectedDay) //key(DateTime)
                .map((Event event) => ListTile(title: Text(event.title))),],),
          ),
              

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
                    onPressed: () async {
                      if (_eventController.text.isEmpty) {
                      } else {
                       DateTime selectedDayWithoutZ = DateTime(_selectedDay.year,_selectedDay.month,_selectedDay.day);
                        if (selectedEvents![selectedDayWithoutZ] != null) {
                          selectedEvents![selectedDayWithoutZ]
                              ?.add(Event(title: _eventController.text));
                        } else {
                          selectedEvents![selectedDayWithoutZ] = [
                            Event(title: _eventController.text)
                          ];
                        }
                        MyEvents _myEvents = MyEvents(
                          event: _eventController.text,
                          date: selectedDayWithoutZ,
                        );
                         enterEventAtFirebase(_myEvents);

                        // ignore: use_build_context_synchronously
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

  Future scheduleFromFirestore() async {
   await FirebaseFirestore.instance
        .collection('myevents')
        .get().then((value) {
          List<DocumentSnapshot> testValue = value.docs;
          testValue.forEach((element) {
            Map<String, dynamic> dbData = element.data() as Map<String, dynamic>;
            print(dbData['date'].runtimeType);
            
            String stringDate = dbData['date'] as String;

            DateTime selectedDay;

            // int.parse()는 숫자로만 된 String을 int로 바꿔줌
            int year = int.parse( stringDate.substring(0, 4));
            int month = int.parse(stringDate.substring(5, 7));
            int day = int.parse(stringDate.substring(8, 10));
            selectedDay = DateTime(year, month, day);

            if (selectedEvents![selectedDay] != null) {
                          selectedEvents![selectedDay]
                              ?.add(Event(title: dbData['event']));
                        } else {
                          selectedEvents![selectedDay] = [
                            Event(title: dbData['event'])
                          ];
                        }
            
          });

          
setState(() {
  
});
          print('#####################');
        });
        
  }
}
