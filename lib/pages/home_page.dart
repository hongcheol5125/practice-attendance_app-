import 'package:attendance_app_final/pages/calendar_page(T).dart';
import 'package:attendance_app_final/pages/calendar_page.dart';
import 'package:attendance_app_final/pages/register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  gotoCalendarPageTeacher() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CalendarPageTeacher(),
      )
    );
  }

  showSnackBar(String text) {
    SnackBar snackBar = SnackBar(
      content: Text(text),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
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
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
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
                        controller: _pwController,
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
                      onPressed: () async {
                        // async와 await를 안하면 firestore에서 자료를 가져오는 시간이 오래 걸리기 때문에 아래 코드가 먼저 실행이 되어서 에러 뜬다
                        String? idAtFirebase;
                        String? pwAtFirebase;
                        String? typeAtFirebse;
                        if (_idController.text == '' ||
                            _pwController.text == '') {
                          showSnackBar('아이디 또는 비밀번호를 입력해 주세요');
                        } else {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(_idController.text)
                              .get()
                              .then((value) {
                            if (value.exists) {
                              Map<String, dynamic> data =
                                  value.data() as Map<String, dynamic>;
                              idAtFirebase = data['id'];
                              pwAtFirebase = data['password'];
                              typeAtFirebse = data['type'];
                            }
                          });
                          if (idAtFirebase != _idController.text) {
                            showSnackBar("아이디가 존재하지 않습니다");
                          } else {
                            if (pwAtFirebase != _pwController.text) {
                              showSnackBar("비밀번호가 일치하지 않습니다");
                            } else {
                              if (typeAtFirebse == '학생') {
                                gotoCalendarPage();
                              } else{
                                gotoCalendarPageTeacher();
                              }
                            }
                          }
                        }
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
                    fontWeight: FontWeight.bold,
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
