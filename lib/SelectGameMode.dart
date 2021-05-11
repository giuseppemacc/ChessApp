import 'package:ChessApp/DifficultySlider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BluetoothManager/BluetoothManager.dart';
import './CustomRadio.dart';

class SelectGameMode extends StatefulWidget {
  @override
  _SelectGameModeState createState() => _SelectGameModeState();
}

class _SelectGameModeState extends State<SelectGameMode> {
  double sizeImage = 50;
  List<String> selection = [null, null, null, null, null];
  List<RadioStructure> bwSelection = [
    RadioStructure(
        pathImage: "contents/images/chesspieces/chess24/wK.png",
        value: "WHITE"),
    RadioStructure(
        pathImage: "contents/images/chesspieces/chess24/bK.png",
        value: "BLACK"),
  ];

  @override
  Widget build(BuildContext context) {
    for (RadioStructure item in bwSelection) {
      if (item.state == true) {
        selection[1] = item.value;
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Gioca"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 20),
              child: Text(
                "Con che pezzi vuoi giocare?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  2,
                  (i) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: InkWell(
                          child: CustomRadio(bwSelection[i]),
                          onTap: () {
                            setState(() {
                              bwSelection
                                  .forEach((element) => element.state = false);
                              bwSelection[i].state = true;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 20),
              child: Text(
                "Imposta la Difficoltà",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            DifficultySlider(),
            RaisedButton(
                child: Text("Conferma"),
                onPressed: () {
                  Provider.of<BluetoothManager>(context)
                      .send("NEWGAME-${selection[1]}");
                  //pop 2 screens
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                }),
          ],
        ));
  }
}
