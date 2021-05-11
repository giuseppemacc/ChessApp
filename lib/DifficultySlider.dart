import 'package:flutter/material.dart';
import './BluetoothManager/BluetoothManager.dart';
import 'package:provider/provider.dart';

class DifficultySlider extends StatefulWidget {
  @override
  _DifficultySliderState createState() => _DifficultySliderState();
}

class _DifficultySliderState extends State<DifficultySlider> {
  double _currentSliderValue = 0;
  @override
  Widget build(BuildContext context) {
    _currentSliderValue = Provider.of<BluetoothManager>(context).difficulty;
    return Slider(
      value: _currentSliderValue,
      min: 1,
      max: 20,
      divisions: 20,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
          Provider.of<BluetoothManager>(context).difficulty =
              _currentSliderValue;
          Provider.of<BluetoothManager>(context)
              .send("DIFFICULTY-${_currentSliderValue.toInt()}");
          print("${_currentSliderValue}");
        });
      },
    );
  }
}
