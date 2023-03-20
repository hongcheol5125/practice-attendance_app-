import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddUser extends StatelessWidget {
  final String id;
  final String password;

  AddUser({required this.id, required this.password});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() async {
      return await users
          .add({
            'id': id,
            'password': password,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return MaterialButton(
      onPressed: addUser,
      child: Text(
        "회원가입",
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _confirmPwController = TextEditingController();
  final String id = '';
  final String password = '';

  registerUserAtFireStore({
    required String id,
    required String password,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set({
          'id': id,
          'password': password,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<bool> isIDExist({required String id}) async {
    bool isExist = false;
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      List<DocumentSnapshot> docs = value.docs.toList();
      docs.forEach((element) {
        Map<String, dynamic> docMap = element.data() as Map<String, dynamic>;
        if (docMap["id"] == id) {
          isExist = true;
        }
      });
    });
    return isExist;
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
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('회원가입'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'ID',
                      style: TextStyle(
                          color: Colors.orange[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextField(
                  controller: _idController,
                  decoration: InputDecoration(
                    hintText: 'ID를 입력해 주세요',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                          color: Colors.orange[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextField(
                  controller: _pwController,
                  decoration: InputDecoration(
                    hintText: 'Password를 입력해 주세요',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Password 확인',
                      style: TextStyle(
                          color: Colors.orange[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextField(
                  controller: _confirmPwController,
                  decoration: InputDecoration(
                    hintText: 'Password를 다시 입력해 주세요',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              MaterialButton(
                color: Colors.orange,
                child: Text('회원가입'),
                onPressed: () async {
                  if (_idController.text == '' ||
                      _pwController.text == '' ||
                      _confirmPwController.text == '') {
                    showSnackBar("빈 칸을 입력해주세요");
                  } else{
                  bool isExist = await isIDExist(id: _idController.text);
                  if (isExist == false) {
                    registerUserAtFireStore(
                      id: _idController.text,
                      password: _pwController.text,
                    );
                    showSnackBar('가입을 축하드립니다!');
                  } else {
                    showSnackBar('이미 존재하는 아이디입니다.');
                  }}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
