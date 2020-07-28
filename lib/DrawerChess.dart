import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './SelectGameMode.dart';
import './BluetoothManager/BluetoothManager.dart';
import './BluetoothManager/BluetoothManagerWidget.dart';

class DrawerChess extends StatefulWidget {
  final BluetoothManager bleManager;
  DrawerChess({this.bleManager, Key key}) : super(key: key);
  @override
  _DrawerChessState createState() => _DrawerChessState();
}

class _DrawerChessState extends State<DrawerChess> {
  selectGameMode() {}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Automatic Chessboard"),
        ),
        body: ListView(
          children: <Widget>[
            RaisedButton(
              child: Text("Bluetooth Manager"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (context) {
                  return SafeArea(
                      child: ChangeNotifierProvider<BluetoothManager>.value(
                    value: widget.bleManager,
                    child: BluetoothManagerWidget(),
                  ));
                }));
              },
            ),
            RaisedButton(
              child: Text("Gioca"),
              onPressed:
                  true //Provider.of<BluetoothManager>(context).connectionState
                      ? () {
                          Navigator.push(context,
                              MaterialPageRoute<void>(builder: (context) {
                            return SafeArea(
                                child: ChangeNotifierProvider<
                                    BluetoothManager>.value(
                              value: widget.bleManager,
                              child: SelectGameMode(),
                            ));
                          }));
                        }
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}
