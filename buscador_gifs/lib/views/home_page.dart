// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:buscador_gifs/views/gif_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

const urlTrending = 'https://api.giphy.com/v1/gifs/trending?api_key=9lVYfZLe5p5Heerk33vX57tId3EqYlp2&limit=20&rating=g';

class _HomeState extends State<Home> {
  String _search = "";
  int _offset = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network("https://developers.giphy.com/static/img/dev-logo-lg.gif"),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                setState(() {
                  _offset = 0;
                  _search = value;
                });
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: _getGifs(_search, _offset),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    default:
                      if (snapshot.hasError)
                        return Container();
                      else
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: createGiftTable(context, snapshot),
                        );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getGifs(String? search, int offset) async {
    String url = "";
    if (search == null || search.isEmpty) {
      url = "https://api.giphy.com/v1/gifs/trending?api_key=9lVYfZLe5p5Heerk33vX57tId3EqYlp2&limit=20&rating=g";
    } else {
      url =
          "https://api.giphy.com/v1/gifs/search?api_key=9lVYfZLe5p5Heerk33vX57tId3EqYlp2&q=$search&limit=19&offset=$offset&rating=g&lang=pt-br";
    }

    var resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      print(resp.body);
      return jsonDecode(resp.body);
    }
  }

  getGifsLength(int length) {
    if (_search.isEmpty)
      return length;
    else
      return length + 1;
  }

  Widget createGiftTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: getGifsLength(snapshot.data["data"].length),
      itemBuilder: (BuildContext context, int index) {
        if (_search.isNotEmpty && snapshot.data["data"].length == index)
          return GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                Text("Carregar Mais"),
              ],
            ),
            onTap: () {
              setState(() {
                _offset += 19;
              });
            },
          );
        else
          return GestureDetector(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GifPage(snapshot.data["data"][index]),
                ),
              );
            },
          );
      },
    );
  }
}

enum TypeReq { trending, search }
