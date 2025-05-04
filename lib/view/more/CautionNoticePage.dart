import 'package:flutter/material.dart';

class CautionNoticePage extends StatelessWidget {
  const CautionNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Caution Notice"),
        backgroundColor: Colors.redAccent,
      ),
      body: const Padding(
        padding:  EdgeInsets.all(16.0),
        child: Text(
          'Caution Notice content goes here...',
          style:  TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
