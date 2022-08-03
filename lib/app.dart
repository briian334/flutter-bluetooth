import 'package:flutter/material.dart';
import 'package:prueba/run.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32 Bluetooth',
      home: Run(),
      debugShowCheckedModeBanner: false,
    );
  }
}
