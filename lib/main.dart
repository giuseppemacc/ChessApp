import 'package:flutter/material.dart';
import './MainPage.dart';

void main() {
  runApp(new Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Automatic Chessboard",
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: SafeArea(child: MainPage()),
    );
  }
}
