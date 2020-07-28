import 'package:flutter/material.dart';
import './MainPage.dart';

void main() {
  runApp(new Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Automatic asd 2",
      theme: ThemeData(primarySwatch: Colors.green),
      home: SafeArea(child: MainPage()),
    );
  }
}
