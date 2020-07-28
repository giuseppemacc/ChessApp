import 'package:flutter/material.dart';
import './MainPage.dart';

void main() {
  runApp(new Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Automatic asd 4",
      theme: ThemeData(primarySwatch: Colors.green),
      home: SafeArea(child: MainPage()),
    );
  }
}
