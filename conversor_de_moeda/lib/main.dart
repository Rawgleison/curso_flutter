// ignore_for_file: prefer_const_constructors

import 'package:conversor_de_moeda/views/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  Color primary = Colors.amber;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(
        // brightness: Brightness.dark,
        colorScheme: ColorScheme.dark().copyWith(
          primary: primary,
          surface: primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
          ),
          labelStyle: TextStyle(color: primary),
          prefixStyle: TextStyle(color: primary, fontSize: 26),
          suffixIconColor: primary,
        ),
      ),
    );
  }
}
