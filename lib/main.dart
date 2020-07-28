import 'package:flutter/material.dart';
import './MainPage.dart';

void main() {
  runApp(new Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: "Automatic asd 2",
=======
      title: "Automatic Test",
>>>>>>> parent of f9c4d0b... Update main.dart
      theme: ThemeData(primarySwatch: Colors.green),
      home: SafeArea(child: MainPage()),
    );
  }
}
