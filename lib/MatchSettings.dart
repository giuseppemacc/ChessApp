import './CustomRadio.dart';

class MatchSettings {
  double vantage = 50;
  bool match = true;
  String bwValue = "";
  List<String> selection = [null, null, null, null, null];

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
}
