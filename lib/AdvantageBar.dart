import 'package:flutter/material.dart';

class AdvantageBar extends StatelessWidget {
  final double width;
  final double height;
  final double w_vantage;
  AdvantageBar({this.width, this.height, this.w_vantage});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
        ),
      ),
      child: LinearProgressIndicator(
        value: this.w_vantage,
        valueColor: AlwaysStoppedAnimation(Colors.white),
        backgroundColor: Colors.black,
      ),
    );
  }
}

// class AdvantageBar extends StatelessWidget {
//   final double width;
//   final double height;
//   final double w_vantage;
//   AdvantageBar({this.width, this.height, this.w_vantage});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Text("${100 - w_vantage}"),
//         Padding(
//           padding: EdgeInsets.only(top: 1, bottom: 1),
//           child: Container(
//             width: width,
//             height: height,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 width: 1, //                   <--- border width here
//               ),
//             ),
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   color: Colors.black,
//                   height: (height - 2) * (100 - w_vantage) / 100.0,
//                   width: width,
//                 ),
//                 Container(
//                   color: Colors.white,
//                   height: (height - 2) * w_vantage / 100.0,
//                   width: width,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Text("$w_vantage"),
//       ],
//     );
//   }
// }
