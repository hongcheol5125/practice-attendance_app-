import 'package:flutter/material.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  TextEditingController qrNumberController = TextEditingController();
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
              hintText: 'write down the qrnumber',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.orange, width: 3.0),
              )),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text('출석!',
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
          ),
        ),
      ],
    ));
  }
}
