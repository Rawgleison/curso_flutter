import 'dart:convert';

import 'package:favoritos_youtube/models/video_model.dart';
import 'package:http/http.dart' as http;

const API_KEY = "AIzaSyCKZvutiWsMCHoIKtS9h4fjssNhQYmQlrg";

class ApiController {
  Future<List<Video>> search(String search) async {
    http.Response resp = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"));
    Map decJson = jsonDecode(resp.body);
    List items = decJson['items'];
    List<Video> videos = items.map((e) {
      return Video.fromMapYoutube(e);
    }).toList();
    return videos;
  }
}
