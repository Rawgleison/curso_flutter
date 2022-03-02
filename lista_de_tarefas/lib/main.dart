import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/views/home.dart';
import 'package:ms_material_color/ms_material_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: MsMaterialColor(0xFF021FC4),
      ),
      home: const HomePage(),
    );
  }
}
