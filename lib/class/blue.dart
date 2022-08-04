import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:prueba/run.dart';

class BlueDart {
  BuildContext context;

  BlueDart({required this.context});

  BluetoothState? _blueState = BluetoothState.UNKNOWN;
  BluetoothConnection? _connection;
  final FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;

  List<BluetoothDevice> devices = [];
  BluetoothDevice? device; //Objeto de la lista de dispositivos

  Future<bool> isConnect() async {
    _blueState = await FlutterBluetoothSerial.instance.state;
    if (_blueState == BluetoothState.STATE_OFF) {
      //SI EL BLUETOOTH ESTÁ APAGADO, SE PIDE AL SISTEMA ENCENDERLO
      await FlutterBluetoothSerial.instance.requestEnable();
      return true;
    }
    return false;
  } //end _blueState

  void _connectBlu(BluetoothDevice device) async {
    if (device != null) {
      if (_connection!.isConnected && this.device == device) {
        debugPrint("Conectado anteriormente!");
      } else {
        this.device = device;
        _connection!.finish();
        await BluetoothConnection.toAddress(device.address).then((value) {
          _connection = value;
          value.input!.listen((event) {
            debugPrint("Recibe datos");
            // showDevices();
          }).onDone(() {
            debugPrint("Se terminó la conexión");
          });
        });
      }
    }
  }

  void _disconnect(BluetoothConnection device) async {
    if (_connection!.isConnected) {
      await _connection!.close();
    }
  }

  void _sendMessage(String state) async {
    String data = "$state\r\t"; //asci cadena de textos
    List<int> bits =
        data.codeUnits; //almacenar las cadenas en formato de 16bits
    Uint8List send = Uint8List.fromList(
        bits); //convertir de 16 bits a 8 para que jale en el serial
    if (_connection!.isConnected) {
      _connection!.output.add(send);
      await _connection!.output.allSent;
    }
  }

  void showDevices(String msg) async {
    await Future.delayed(const Duration(seconds: 2));
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: const Text("¿Seguro que deseas cerrar la aplicación?"),
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Sí")),
                    ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No"))
                  ]),
            ));
  }

  void getDevices() async {
    try {
      devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      showDevices('Error');
    }
  }
}
