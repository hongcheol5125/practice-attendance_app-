import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class QrPageTeacher extends StatefulWidget {
  const QrPageTeacher({super.key});

  @override
  State<QrPageTeacher> createState() => _QrPageTeacherState();
}

class _QrPageTeacherState extends State<QrPageTeacher> {
  String randomNumbers = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR 생성기'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            randomNumbers,
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  return onRandomNumberGenerate();
                },
                child: Text('랜덤숫자 생성!'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onRandomNumberGenerate() {
    final rand = Random();
    final number = rand.nextInt(10000);

    setState(() {
      randomNumbers = number.toString();
    });
  }
}
