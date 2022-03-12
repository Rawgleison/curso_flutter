import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/controller/api_controller.dart';

import '../models/video_model.dart';

class VideoBloc extends BlocBase {
  late ApiController api;
  List<Video> videos = [];

  VideoBloc() {
    api = ApiController();
    _videosController.stream.listen(_search);
  }

  final StreamController<List<Video>> _videosController = StreamController<List<Video>>();
  Stream get outVideo => _videosController.stream;

  final StreamController<String> _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  void _search(search) async {
    videos = await api.search(search);
    print('videos: $videos');
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }
}
