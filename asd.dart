import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BluetoothManager/BluetoothManager.dart';

class SelectGameMode extends StatefulWidget {
  @override
  _SelectGameModeState createState() => _SelectGameModeState();
}

class _SelectGameModeState extends State<SelectGameMode> {
  double sizeImage = 50;
  List<String> selection = [null, null, null, null];
  List<RadioStructure> bwSelection = [
    RadioStructure(
        pathImage: "contents/images/chesspieces/chess24/wK.png", value: "W"),
    RadioStructure(
        pathImage: "contents/images/chesspieces/chess24/bK.png", value: "B"),
  ];

  List<RadioStructure> posRobotSelection = [
    RadioStructure(pathImage: "contents/images/redx.png", value: "X"),
    RadioStructure(
        pathImage: "contents/images/chesspieces/chess24/wK.png", value: "W"),
    RadioStructure(
        pathImage: "contents/images/chesspieces/chess24/bK.png", value: "B"),
    RadioStructure(pathImage: "contents/images/wb.png", value: "WB"),
  ];

  List<RadioStructure> posTuSelection = [
    RadioStructure(pathImage: "contents/images/redx.png", value: "X"),
    RadioStructure(
        pathImage: "contents/images/chesspieces/chess24/wK.png", value: "W"),
    RadioStructure(
        pathImage: "contents/images/chesspieces/chess24/bK.png", value: "B"),
    RadioStructure(pathImage: "contents/images/wb.png", value: "WB"),
  ];
  @override
  Widget build(BuildContext context) {
    for (RadioStructure item in bwSelection) {
      if (item.state == true) {
        selection[1] = item.value;
      }
    }
    for (RadioStructure item in posTuSelection) {
      if (item.state == true) {
        selection[3] = item.value;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Gioca"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
      ),
      body: selection[0] == null
          ? ListView(
              children: <Widget>[
                RaisedButton(
                  child: Text("Nuova Partita"),
                  onPressed: () {
                    setState(() {
                      selection[0] = "NP";
                      selection[2] = "POS";
                    });
                  },
                ),
                RaisedButton(
                  child: Text("Gioca Posizione"),
                  onPressed: () {
                    setState(() {
                      selection[0] = "giocaposizione";
                    });
                  },
                ),
              ],
            )
          : (selection[0] == "NP")
              ? ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 20, top: 20),
                      child: Text(
                        "Scegli i Pezzi",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Gioca con:"),
                          Row(
                            children: List.generate(2, (i) {
                              return Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  child: InkWell(
                                    child: CustomRadio(bwSelection[i]),
                                    onTap: () {
                                      setState(() {
                                        bwSelection.forEach(
                                            (element) => element.state = false);
                                        bwSelection[i].state = true;
                                      });
                                    },
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Posiziona",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 35),
                                child: Text("Tu:"),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 0),
                                child: Text("Robot:"),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Row(
                                  children: List.generate(4, (i) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        child: InkWell(
                                          child: CustomRadio(posTuSelection[i]),
                                          onTap: () {
                                            setState(() {
                                              posTuSelection.forEach(
                                                  (element) =>
                                                      element.state = false);
                                              posTuSelection[i].state = true;

                                              controlState(posTuSelection,
                                                  posRobotSelection, i);
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Row(
                                  children: List.generate(4, (i) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        child: InkWell(
                                          child:
                                              CustomRadio(posRobotSelection[i]),
                                          onTap: () {
                                            setState(() {
                                              posRobotSelection.forEach(
                                                  (element) =>
                                                      element.state = false);
                                              posRobotSelection[i].state = true;
                                              controlState(posRobotSelection,
                                                  posTuSelection, i);
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    RaisedButton(
                      child: Text("Conferma $selection"),
                      onPressed:
                          ((selection[1] != null) && (selection[3] != null))
                              ? () {
                                  Provider.of<BluetoothManager>(context).send(
                                      "${selection[0]}-${selection[1]}-${selection[2]}-${selection[3]}");

                                  Navigator.pop(context);
                                }
                              : null,
                    ),
                  ],
                )
              : ListView(
                  children: <Widget>[
                    Text("gli fsk sono fsk ma senza fsk"),
                  ],
                ),
    );
  }
}

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

//questa funzione serve per invertire gli state true di ogni RadioStructure delle due righe in base ad un controllo
void controlState(List first, List second, int i) {
  if (first[i].value == "X") {
    second.forEach((element) => element.state = false);
    second[3].state = true;
  } else if (first[i].value == "W") {
    second.forEach((element) => element.state = false);
    second[2].state = true;
  } else if (first[i].value == "B") {
    second.forEach((element) => element.state = false);
    second[1].state = true;
  } else if (first[i].value == "WB") {
    second.forEach((element) => element.state = false);
    second[0].state = true;
  }
}
