import 'package:flutter/material.dart';

class SmartDevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Smart Devices")),
      body: Center(
        child: Text(
          "Control Your Smart Kitchen Devices!",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
