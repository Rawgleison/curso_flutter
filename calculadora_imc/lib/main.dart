import 'package:calculadora_imc/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:material_color_gen/material_color_gen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculadora de IMC",
      home: HomePage(),
      theme: ThemeData(
          primarySwatch: Color.fromARGB(255, 42, 121, 34).toMaterialColor()),
    );
  }
}
