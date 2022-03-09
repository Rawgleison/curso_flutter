import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';

class GifPage extends StatelessWidget {
  const GifPage(this._gifData);

  final Map _gifData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_gifData["title"]),
        actions: [
          IconButton(
            onPressed: () {
              Share.share(_gifData["images"]["original"]["url"]);
            },
            icon: const Icon(Icons.share),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child:
              FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: _gifData["images"]["original"]["url"]),
        ),
      ),
    );
  }
}
