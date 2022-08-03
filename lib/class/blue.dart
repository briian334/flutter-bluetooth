import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BlueDart {
  BluetoothState? _blueState = BluetoothState.UNKNOWN;
  BluetoothConnection? _connection;
  final FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;

  List<BluetoothDevice> devices = [];
  Future<bool> isConnect() async {
    _blueState = await FlutterBluetoothSerial.instance.state;
    if (_blueState == BluetoothState.STATE_OFF) {
      //SI EL BLUETOOTH ESTÁ APAGADO, SE PIDE AL SISTEMA ENCENDERLO
      await FlutterBluetoothSerial.instance.requestEnable();
      return true;
    }
    return false;
  }
}
