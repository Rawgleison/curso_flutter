import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/bloc/videos_bloc.dart';
import 'package:favoritos_youtube/controller/api_controller.dart';
import 'package:favoritos_youtube/const.dart';
import 'package:favoritos_youtube/delegate/search_delegate.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 35,
          child: const Image(
            image: AssetImage("$imagesPath/youtube_logo.png"),
          ),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("0"),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star),
          ),
          IconButton(
            onPressed: () async {
              String? src = await showSearch(context: context, delegate: Search());
              if (src != null && src.isNotEmpty) {
                BlocProvider.getBloc<VideoBloc>().inSearch.add(src);
              }
              // print(src);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
