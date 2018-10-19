import 'package:convvls/data/favorite.dart';
import 'package:convvls/model/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TextPage extends StatefulWidget {
  final Favorite fav;
  TextPage(this.fav);

  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
        builder: (context, child, model) => Stack(
              fit: StackFit.expand,
              children: _buildStackChildren(context, size, model),
            ),
      ),
    );
  }

  List<Widget> _buildStackChildren(
      BuildContext context, Size size, MainModel model) {
    List<Widget> children = <Widget>[];
    return children;
  }
}
