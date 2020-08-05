import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';

import './BluetoothManager.dart';
import './SelectBondedDevicePage.dart';

class BluetoothManagerWidget extends StatefulWidget {
  @override
  _BluetoothManagerWidgetState createState() => _BluetoothManagerWidgetState();
}

class _BluetoothManagerWidgetState extends State<BluetoothManagerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<BluetoothManager>(context).initBluetoothState();
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth Manager"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Abilita Bluetooth"),
            trailing: Switch(
              value: Provider.of<BluetoothManager>(context)
                  .bluetoothState
                  .isEnabled,
              onChanged: (bool value) {
                future() async {
                  if (value)
                    await FlutterBluetoothSerial.instance.requestEnable();
                  else
                    await FlutterBluetoothSerial.instance.requestDisable();
                }

                future().then((_) {
                  setState(() {});
                });
              },
            ),
          ),
          ListTile(
            title: Text("Vai ad impostazione Bluetooth"),
            trailing: RaisedButton(
              child: Icon(Icons.settings_bluetooth),
              onPressed: () => FlutterBluetoothSerial.instance.openSettings(),
            ),
          ),
          RaisedButton(
            child: Text("Connettiti ad un dispositivo associato"),
            onPressed: () async {
              final BluetoothDevice selectedDevice =
                  await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SelectBondedDevicePage(checkAvailability: false);
                  },
                ),
              );
              if (selectedDevice != null) {
                Provider.of<BluetoothManager>(context).connect(selectedDevice);
              }
            },
          ),
          ListTile(
            title: Text("Stato Connessione"),
            trailing: Consumer<BluetoothManager>(
              builder: (context, bleManager, child) {
                return bleManager.connectionState
                    ? Text(
                        "ON",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      )
                    : Text(
                        "OFF",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      );
              },
            ),
          ),
          //TODO: QUESTE DUE LIST TILE SONO DI ESEMPIO PER VERIFICARE IL CORRETTO FUNZIONAMENTO DEL BLUETOOTH POI LEVALE COGLIONE
          //ListTile(
          //  title: Text("Output"),
          //  trailing: RaisedButton(
          //    child: Text("send"),
          //    onPressed: () =>
          //        {Provider.of<BluetoothManager>(context).send("CB")},
          //  ),
          //),
          //ListTile(
          //  title: Text("Input"),
          //  trailing: Consumer<BluetoothManager>(
          //    builder: (context, bleManager, child) {
          //      return Text(bleManager.recived);
          //    },
          //  ),
          //),
        ],
      ),
    );
  }
}
