import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final RadioStructure radioItem;
  CustomRadio(this.radioItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: radioItem.state ? Colors.grey[350] : null,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Image.asset(radioItem.pathImage),
      ),
    );
  }
}

class RadioStructure {
  bool state;
  final String pathImage;
  final String value;
  RadioStructure({this.state = false, this.pathImage, this.value});
}
