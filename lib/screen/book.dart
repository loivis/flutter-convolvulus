import 'package:cached_network_image/cached_network_image.dart';
import 'package:convvls/data/book.dart';
import 'package:convvls/model/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BookPage extends StatefulWidget {
  final Book book;
  BookPage(this.book);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('简介'),
      centerTitle: true,
      actions: <Widget>[
        ScopedModelDescendant<MainModel>(
          builder: (context, child, model) => IconButton(
                icon: model.isFavorite(widget.book.key)
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_border),
                onPressed: () {
                  if (model.isFavorite(widget.book.key)) {
                    model.removeFavorite(widget.book.key);
                  } else {
                    model.addFavorite(widget.book);
                  }
                },
              ),
        ),
        IconButton(
          icon: Icon(Icons.cloud_download),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: widget.book.image,
                height: 100.0,
                placeholder: new CircularProgressIndicator(),
                errorWidget: new Icon(Icons.error),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(5.0),
                      child: Text(widget.book.title,
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Container(
                      margin: EdgeInsets.all(5.0),
                      child: Text([
                        widget.book.author,
                        widget.book.site,
                      ].join(' | '))),
                  Container(
                      margin: EdgeInsets.all(5.0),
                      child: Text(widget.book.update)),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('收藏'),
                      onPressed: () {
                        if (model.isFavorite(widget.book.key)) {
                          model.removeFavorite(widget.book.key);
                        } else {
                          model.addFavorite(widget.book);
                        }
                      },
                    ),
                    RaisedButton(
                      child: Text('阅读'),
                      onPressed: () {},
                    )
                  ],
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(widget.book.intro),
          ),
        ],
      ),
    );
  }
}
