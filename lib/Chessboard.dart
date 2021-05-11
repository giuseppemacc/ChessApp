import 'package:ChessApp/DifficultySlider.dart';

import './AdvantageBar.dart';
import 'package:flutter/material.dart';
import './BluetoothManager/BluetoothManager.dart';
import 'package:provider/provider.dart';

import 'package:flutter/widgets.dart';

class Chessboard extends StatefulWidget {
  final BluetoothManager bleManager;
  Chessboard({this.bleManager});
  @override
  _Chessboard createState() => _Chessboard();
}

class _Chessboard extends State<Chessboard> {
  double vantage = 0.5;
  bool match = true;
  //TODO: aggiungere un setstate per match che quando si è in partita diventi true (quindi quando vengono inviati NP-(W/B) o GP-(W/B))
  static Map chessboard = {
    "RIGHT": [
      List<String>(8),
      List<String>(8),
    ],
    "GRID": [
      List<String>(8),
      List<String>(8),
      List<String>(8),
      List<String>(8),
      List<String>(8),
      List<String>(8),
      List<String>(8),
      List<String>(8),
    ],
    "LEFT": [
      List<String>(8),
      List<String>(8),
    ],
  };

  void setPiece(String type_string, int y, int x, String value) {
    chessboard[type_string][y][x] = value;
  }

  //CB-LEFT-00wP-00br...-RIGHT-O1wK...-GRID-80bn
  void bleValueManagement() {
    setState(() {
      while (Provider.of<BluetoothManager>(context).buffer.isNotEmpty) {
        String recived = Provider.of<BluetoothManager>(context).recived;
        String sent = Provider.of<BluetoothManager>(context).sent;

        if (recived.startsWith("CB")) {
          List<String> list_chessboard = recived.split("-");
          print(list_chessboard);

          for (var i = 2; i < 18; i++) {
            String values = list_chessboard[i];
            String piece = values.substring(2);
            int y = int.parse(values[1]); // x
            int x = int.parse(values[0]); // y
            setPiece("LEFT", y, x, piece);
          }
          for (var i = 19; i < 35; i++) {
            String values = list_chessboard[i];
            String piece = values.substring(2);
            int y = int.parse(values[1]); // x
            int x = int.parse(values[0]); // y
            setPiece("RIGHT", y, x, piece);
          }
          for (var i = 36; i < 100; i++) {
            String values = list_chessboard[i];
            String piece = values.substring(2);
            int x = int.parse(values[1]);
            int y = int.parse(values[0]);
            setPiece("GRID", y, x, piece);
          }
        } else if (recived.startsWith("VANTAGE")) {
          this.vantage = double.parse(recived.split("-")[1]) / 100;
        }

        // if (sent.startsWith("NP-") || sent.startsWith("GP-")) {
        //   match = true;
        // }
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bleValueManagement();
    return Container(
      child: ListView(
        children: <Widget>[
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("contents/images/scacchiera_big.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Grid(
                    width: 310,
                    height: 310,
                    row: 8,
                    column: 8,
                    piece_height: 30,
                    piece_width: 30,
                    grid_type: "GRID",
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: AdvantageBar(
                  width: 300,
                  height: 10,
                  w_vantage: this.vantage,
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
                              RaisedButton(
                                child: Text("Arrenditi"),
                                onPressed: () {
                                  Provider.of<BluetoothManager>(context)
                                      .send("SURRENDER");
                                  Navigator.of(contextPopup).pop();
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 40),
                                child: Text(
                                  "Livello Computer",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: ChangeNotifierProvider<
                                    BluetoothManager>.value(
                                  value: widget.bleManager,
                                  child: DifficultySlider(),
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
                      grid_type: "LEFT",
                    ),
                    Grid(
                      width: 250,
                      height: 40,
                      row: 2,
                      column: 8,
                      piece_height: 20,
                      piece_width: 20,
                      grid_type: "RIGHT",
                    ),
                  ],
                ),
              ),
            ),
          ),
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
