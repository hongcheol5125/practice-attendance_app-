import 'package:attendance_app_final/model/number.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState(
      numberFromFirestore:
          FirebaseFirestore.instance.collection('random_number').get().toString());
}

class _QrPageState extends State<QrPage> {
  TextEditingController qrNumberController = TextEditingController();

  final String numberFromFirestore;

  _QrPageState({required this.numberFromFirestore});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0),
          child: TextField(
            controller: qrNumberController,
            decoration: InputDecoration(
                hintText: 'write down the QR number',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.orange, width: 3.0),
                )),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('random_number')
                .get()
                .then((value) async {
              if (qrNumberController.text == numberFromFirestore) {
                await FirebaseFirestore.instance
                    .collection('random_number')
                    .doc(qrNumberController.text)
                    .update({'attendance': '출석!'})
                    .then((value) => print("User Updated"))
                    .catchError(
                        (error) => print("Failed to update user: $error"));
              }
            });
          },
          child: Text('출석!'),
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
          ),
        ),
      ],
    ));
  }
}
