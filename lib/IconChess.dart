import 'package:flutter/material.dart';

class IconChess extends StatelessWidget {
  final double size = 50;
  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(
        size: size,
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Container(
          width: size,
          height: size,
          child: Image.asset("contents/images/icon.png"),
        ),
      ),
    );
  }
}
