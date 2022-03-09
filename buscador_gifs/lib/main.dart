import 'package:buscador_gifs/views/gif_page.dart';
import 'package:buscador_gifs/views/home_page.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(app());
}

class app extends StatelessWidget {
  const app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark().copyWith(
          background: Colors.black,
          primary: Colors.white,
        ),
      ),
      home: Home(),
    );
  }
}
