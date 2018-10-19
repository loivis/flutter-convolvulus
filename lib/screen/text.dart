import 'package:convvls/data/favorite.dart';
import 'package:flutter/material.dart';

class TextPage extends StatefulWidget {
  final Favorite fav;
  TextPage(this.fav);

  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(widget.fav.source),
    );
  }
}
