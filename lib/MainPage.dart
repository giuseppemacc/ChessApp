import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './IconChess.dart';
import './DrawerChess.dart';
import './BluetoothManager/BluetoothManager.dart';
import './Chessboard.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  BluetoothManager bleManager = BluetoothManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    bleManager.connection.dispose();
    bleManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BluetoothManager>(
      create: (context) => bleManager,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              IconChess(),
              Text("Automatic Chessboard"),
            ],
          ),
        ),
        body: ChangeNotifierProvider<BluetoothManager>.value(
          value: bleManager,
          child: Chessboard(bleManager: bleManager),
        ),
        drawer: ChangeNotifierProvider<BluetoothManager>.value(
          value: bleManager,
          child: DrawerChess(bleManager: bleManager),
        ),
      ),
    );
  }
}
