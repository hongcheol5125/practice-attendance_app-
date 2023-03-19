import 'package:attendance_app_final/pages/calendar_page.dart';
import 'package:attendance_app_final/pages/register_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  gotoCalendarPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CalendarPage(),
      ),
    );
  }

  gotoRegisterPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/imgs/alcohol.jpg'),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                child: Row(
                  children: [
                    Text(
                      'id : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _idController,
                        decoration: InputDecoration(
                          hintText: 'Write down your id',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                child: Row(
                  children: [
                    Text(
                      'Password : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _idController,
                        decoration: InputDecoration(
                          hintText: 'Write down your id',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: MaterialButton(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '로그인',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        return gotoCalendarPage();
                      },
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  return gotoRegisterPage();
                },
                child: Text(
                  '회원가입',
                  style: TextStyle(
                    fontWeight : FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
