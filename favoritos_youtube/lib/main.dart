import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/bloc/videos_bloc.dart';
import 'package:favoritos_youtube/views/home_page.dart';
import 'package:flutter/material.dart';

import 'models/video_model.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      dependencies: [
        Dependency(
          (i) {},
        )
      ],
      blocs: [Bloc((I) => VideoBloc())],
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: const ColorScheme.dark().copyWith(
          background: Colors.black12,
          primary: Colors.black,
        )),
        home: HomePage(),
      ),
    );
  }
}
