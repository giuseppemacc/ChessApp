import './AdvantageBar.dart';
import 'package:flutter/material.dart';
import './BluetoothManager/BluetoothManager.dart';
import 'package:provider/provider.dart';
import './CustomRadio.dart';

class Chessboard extends StatefulWidget {
  @override
  _Chessboard createState() => _Chessboard();
}

class _Chessboard extends State<Chessboard> {
  double vantage = 50;
  bool match = true;
  //TODO: aggiungere un setstate per match che quando si è in partita diventi true (quindi quando vengono inviati NP-(W/B) o GP-(W/B))
  static Map chessboard = {
    "bpn": [
      List<String>(8), //["bR", "bN", "bB", "bQ", "bK", "bB", "bN", "bR"],
      List<String>(8), //["bP", "bP", "bP", "bP", "bP", "bP", "bP", "bP"],
    ],
    "grid": [
      ["bR", "bN", "bB", "bQ", "bK", "bB", "bN", "bR"], //List<String>(8),
      ["bP", "bP", "bP", "bP", "bP", "bP", "bP", "bP"], //List<String>(8),
      List<String>(8),
      List<String>(8),
      List<String>(8),
      List<String>(8),
      ["wP", "wP", "wP", "wP", "wP", "wP", "wP", "wP"], //List<String>(8),
      ["wR", "wN", "wB", "wQ", "wK", "wB", "wN", "wR"], //List<String>(8),
    ],
    "wpn": [
      List<String>(8), //["wR", "wN", "wB", "wQ", "wK", "wB", "wN", "wR"],
      List<String>(8), //["wP", "wP", "wP", "wP", "wP", "wP", "wP", "wP"],
    ],
  };

  // questi due variabili servono solo per il gioca posizione
  List<RadioStructure> bwSelection = [
    RadioStructure(
        pathImage: "contents/images/chesspieces/chess24/wK.png", value: "W"),
    RadioStructure(
        pathImage: "contents/images/chesspieces/chess24/bK.png", value: "B"),
  ];

  String bwValue = "";

  void setPiece(String type_string, int y, int x, String value) {
    chessboard[type_string][y][x] = value;
  }

  void bleValueManagement() {
    setState(() {
      while (Provider.of<BluetoothManager>(context).buffer.isNotEmpty) {
        String recived = Provider.of<BluetoothManager>(context).recived;
        String sent = Provider.of<BluetoothManager>(context).sent;

        if (recived.startsWith("CB")) {
          List<String> values = recived.split("-");
          setPiece(values[1], int.parse(values[2]), int.parse(values[3]),
              values[4].substring(0, 2));
        } else if (recived.startsWith("V")) {
          //set vantage
        }

        if (sent.startsWith("NP-") || sent.startsWith("GP-")) {
          match = true;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (RadioStructure item in bwSelection) {
      if (item.state == true) {
        bwValue = item.value;
      }
    }
    bleValueManagement();
    return Container(
      child: ListView(
        children: <Widget>[
          (Provider.of<BluetoothManager>(context).sent == "GPFREE")
              ? Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 10),
                  child: Text(
                    "Posizionamento Libero",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                )
              : Container(),
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("contents/images/board.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Grid(
                  width: 310,
                  height: 310,
                  row: 8,
                  column: 8,
                  piece_height: 32,
                  piece_width: 32,
                  grid_type: "grid",
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: AdvantageBar(
                      width: 10,
                      height: 250,
                      w_vantage: vantage,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () => {
                      showDialog(
                          context: context,
                          builder: (BuildContext contextPopup) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    title: Text("Ruota Scacchiera"),
                                    trailing: IconButton(
                                      icon: Icon(Icons.import_export),
                                      onPressed:
                                          Provider.of<BluetoothManager>(context)
                                                  .connectionState
                                              ? () {
                                                  Navigator.of(contextPopup)
                                                      .pop();
                                                }
                                              : null,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("Arrenditi"),
                                    trailing: IconButton(
                                      icon: Icon(Icons.cancel),
                                      onPressed: (Provider.of<BluetoothManager>(
                                                      context)
                                                  .connectionState &&
                                              (match == true))
                                          ? () {
                                              Navigator.of(contextPopup).pop();
                                            }
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                    },
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Grid(
                      width: 250,
                      height: 40,
                      row: 2,
                      column: 8,
                      piece_height: 20,
                      piece_width: 20,
                      grid_type: "wpn",
                    ),
                    Grid(
                      width: 250,
                      height: 40,
                      row: 2,
                      column: 8,
                      piece_height: 20,
                      piece_width: 20,
                      grid_type: "bpn",
                    ),
                  ],
                ),
              ),
            ),
          ),
          (Provider.of<BluetoothManager>(context).sent == "GPFREE")
              ? Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Text("Gioca con:"),
                          padding: EdgeInsets.only(right: 10),
                        ),
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
                    Padding(
                      child: Container(
                        width: 100,
                        height: 40,
                        child: RaisedButton(
                          onPressed: () => {
                            Provider.of<BluetoothManager>(context)
                                .send("GP-$bwValue")
                          },
                          child: Text("Gioca"),
                        ),
                      ),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

class Grid extends StatefulWidget {
  final int row;
  final int column;
  final double width;
  final double height;
  final Color color;
  final double piece_height;
  final double piece_width;
  final String grid_type;
  Grid(
      {this.row,
      this.column,
      this.height,
      this.width,
      this.color,
      this.piece_height,
      this.piece_width,
      this.grid_type,
      Key key})
      : super(key: key);
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(widget.row, (y) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(widget.column, (x) {
              return SizedBox(
                width: widget.piece_width,
                height: widget.piece_height,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Image.asset(
                      /*TODO: levare grid_type (string) come parametro e mettere direttamente un array bidimensionale (List) da cui pescare il valore
                    questo per permettere di creare una scacchiera personalizzata al posto di utilizzare un immagine*/
                      "contents/images/chesspieces/128x128/${_Chessboard.chessboard[widget.grid_type][y][x]}.png"),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
