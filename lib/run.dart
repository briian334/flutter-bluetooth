import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:prueba/class/blue.dart';
import 'package:after_layout/after_layout.dart';

bool switchValue = false;
String dropdownValue = "ESP-32";

class Run extends StatefulWidget {
  Run({Key? key}) : super(key: key);

  @override
  State<Run> createState() => _RunState();
}

class _RunState extends State<Run> with AfterLayoutMixin {
  BlueDart? blue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //VERIFICAR QUE EL DISPOSITIVO ESTE CONECTADO AL BLUETOOTH
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //ELIMINAR EL OBJETO BLUETOOTH
    //CERRAR LA CONEXIÓN BLUEEE
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: <Color>[
            Color(0xff00afbf),
            Color(0xff0099b9),
            Color(0xff0082b2),
            Color(0xff006ca9),
            Color(0xff00559c),
            Color(0xff003e8c),
            Color(0xff002677),
            Color(0xff00085e),
          ], // Gradient from https://learnui.design/tools/gradient-generator.html
          tileMode: TileMode.mirror,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.10,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Selecciona un dispositivo"),
                        const SizedBox(
                          width: 20,
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 183, 58, 58)),
                          underline: Container(
                            height: 2,
                            color: Color.fromARGB(255, 255, 77, 77),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>[
                            'ESP-32',
                            'Arduino',
                            'Raspberry',
                            'Otro'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                            onPressed: () {}, child: const Text("Conectar"))
                      ]),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: SwitchListTile.adaptive(
                      title: const Text("Habilitar el bluetooth"),
                      subtitle: const Text("Deshabilitar el bluetooth"),
                      value: switchValue,
                      onChanged: (value) {
                        setState(() {
                          switchValue = value;
                        });
                      }),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.10,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Enviar:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Si",
                              style: TextStyle(fontSize: 20),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "No",
                              style: TextStyle(fontSize: 20),
                            ))
                      ]),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      )),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    blue = BlueDart(context: context);
    blue!.isConnect();
  }
}
