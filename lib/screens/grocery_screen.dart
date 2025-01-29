import 'package:flutter/material.dart';

class GroceryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grocery List")),
      body: Center(
        child: Text(
          "Manage Your Grocery List!",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
