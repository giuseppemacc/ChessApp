import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothManager extends ChangeNotifier {
  double difficulty = 15;
  String _recived = "";
  String _sent = "";
  List<String> _buffer = new List<String>();
  BluetoothConnection connection;

  String get sent => _sent;
  List<String> get buffer => _buffer;
  String get recived {
    if (_buffer.isNotEmpty) {
      String val = _buffer[0];
      _buffer.removeAt(0);
      return val;
    } else {
      return "";
    }
  }

  bool get isConnected => connection != null && connection.isConnected;

  set sent(String value) {
    _sent = value;
    notifyListeners();
  }

  BluetoothState bluetoothState = BluetoothState.UNKNOWN;
  bool connectionState = false;

  void initBluetoothState() {
    FlutterBluetoothSerial.instance.state.then((state) {
      bluetoothState = state;
      notifyListeners();
    });

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      bluetoothState = state;
      if (!state.isEnabled) {
        connectionState = false;
      }
      notifyListeners();
    });
  }

  void connect(BluetoothDevice device) {
    BluetoothConnection.toAddress(device.address).then((_connection) {
      connection = _connection;
      connectionState = isConnected;
      notifyListeners();
      connection.input.listen(_onDataReceived).onDone(() {
        connectionState = isConnected;
        notifyListeners();
      });
    }).catchError((error) {});
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    _recived = String.fromCharCodes(buffer);
    _buffer.add(_recived);
    print(_buffer);
    notifyListeners();
  }

  void send(String text) async {
    text = text.trim();
    try {
      connection.output.add(utf8.encode(text + "\r\n"));
      await connection.output.allSent;
    } catch (e) {}
    notifyListeners();

    sent = text;
  }
}
