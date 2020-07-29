import 'package:flutter/material.dart';
import 'BluetoothManager/BluetoothManager.dart';
import 'package:provider/provider.dart';

class Chessboard extends StatefulWidget {
  @override
  _Chessboard createState() => _Chessboard();
}

class _Chessboard extends State<Chessboard> {
  static Map chessboard = {
    "bpn": [
      ["bQ", "bQ"],
      List<String>(2),
      List<String>(2),
      List<String>(2),
      List<String>(2),
      List<String>(2),
      List<String>(2),
      List<String>(2),
      List<String>(2),
    ], //[List<String>(9), List<String>(9)],
    "grid": [
      ["bR", "bN", "bB", "bQ", "bK", "bB", "bN", "bR"],
      ["bP", "bP", "bP", "bP", "bP", "bP", "bP", "bP"],
      List<String>(8),
      List<String>(8),
      List<String>(8),
      List<String>(8),
      ["wP", "wP", "wP", "wP", "wP", "wP", "wP", "wP"],
      ["wR", "wN", "wB", "wQ", "wK", "wB", "wN", "wR"],
    ],
    "wpn": [
      ["wQ", "wQ"],
      List<String>(2),
      List<String>(2),
      List<String>(2),
      List<String>(2),
      List<String>(2),
      List<String>(2),
      List<String>(2),
      List<String>(2),
    ],
  };

  void setPiece(String type_string, int x, int y, String value) {
    chessboard[type_string][y][x] = value;
  }

  @override
  void initState() {
    super.initState();
  }

  void bleSetPiece() {
    //CB-0-0-wK\r\n
    if (Provider.of<BluetoothManager>(context).recived.startsWith("CB")) {
      setState(() {
        String rec = Provider.of<BluetoothManager>(context).recived;
        setPiece("grid", int.parse(rec[3]), int.parse(rec[5]), rec[7] + rec[8]);
        print("Scacchiera aggiornata");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bleSetPiece();
    return Container(
      child: Row(
        children: <Widget>[
          Grid(
            width: 35,
            height: 250,
            //color: Colors.grey,
            row: 9,
            column: 2,
            piece_height: 15,
            piece_width: 15,
            grid_type: "bpn",
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("contents/images/chessboard.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Grid(
                width: 250,
                height: 250,
                row: 8,
                column: 8,
                piece_height: 20,
                piece_width: 20,
                grid_type: "grid",
              ),
            ),
          ),
          Grid(
            width: 35,
            height: 250,
            //color: Colors.amber[50],
            row: 9,
            column: 2,
            piece_height: 15,
            piece_width: 15,
            grid_type: "wpn",
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
                      "contents/images/chesspieces/symbol/${_Chessboard.chessboard[widget.grid_type][y][x]}.png"),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
