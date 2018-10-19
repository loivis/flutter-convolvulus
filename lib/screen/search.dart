import 'package:convvls/model/book.dart';
import 'package:convvls/model/main.dart';
import 'package:convvls/screen/book.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      resizeToAvoidBottomPadding: false,
    );
  }

  AppBar _buildAppBar() {
    _textController.addListener(() {
      // if (_controller.text.isEmpty) {
      //   print('null input');
      //   return;
      // }
    });

    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      title: Directionality(
        textDirection: Directionality.of(context),
        child: ScopedModelDescendant<MainModel>(
          builder: (context, child, model) => Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    decoration: InputDecoration(
                      hintText: "type to search",
                      hintStyle: TextStyle(color: Colors.black38),
                      isDense: true,
                    ),
                    onSubmitted: (String keywords) async {
                      if (keywords == "") {
                        return;
                      }
                      model.startSearch(_textController.text);
                    },
                    autofocus: false,
                    controller: _textController,
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _textController.clear();
                      model.resetSearch();
                    },
                  )
                ],
              ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        if (model.searchProgress == 'ready') {
          List<String> history = model.searchHistory;
          if (history.length == 0) {
            model.readSearchHistory();
            return Center(child: Text('ready to search'));
          }
          return ListView.builder(
            itemCount: history.length * 2 + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildSearchHistoryTitle();
              }
              return _buildSearchHistory(history, index);
            },
          );
        } else if (model.searchProgress == "inprogress") {
          return Center(child: CircularProgressIndicator());
        } else if (model.searchProgress == 'done') {
          if (model.searchResult.length == 0) {
            return Container(
              height: 100.0,
              alignment: Alignment.center,
              child: Text("nothing found", style: TextStyle(fontSize: 20)),
            );
          }
          return ListView.builder(
            itemCount: model.searchResult.length,
            itemBuilder: _buildSearchResult(model),
          );
        }
      },
    );
  }

  Container _buildSearchHistoryTitle() {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Search History',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            ScopedModelDescendant<MainModel>(
                builder: (context, child, model) => IconButton(
                      icon: Icon(Icons.delete_sweep, size: 30),
                      onPressed: () {
                        model.resetSearchHistory();
                      },
                    )),
          ],
        ));
  }

  Widget _buildSearchHistory(List<String> history, int index) {
    if (index % 2 == 1) {
      return Divider();
    }

    int i = (index / 2 - 1).round();
    return ScopedModelDescendant<MainModel>(
        builder: (context, child, model) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(history[i], textAlign: TextAlign.left),
                  onPressed: () {
                    _textController.text = history[i];
                    model.startSearch(history[i]);
                    // Focus.clear(context);
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  },
                ),
                IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  icon: Icon(Icons.close),
                  onPressed: () {
                    model.removeFromSearchHistory(i);
                  },
                ),
              ],
            ));
  }

  _buildSearchResult(model) {
    return (BuildContext context, int index) {
      Book book = model.searchResult[index];
      Widget leading = CachedNetworkImage(
        imageUrl: book.image,
        height: 75.0,
        placeholder: new CircularProgressIndicator(),
        errorWidget: new Icon(Icons.error),
      );
      Widget title = Text(
        book.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      );
      Widget subtitle = Text(
        '${book.author} | ${book.site}' + '\n${book.intro}',
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      );
      return Card(
        margin: EdgeInsets.all(5.0),
        elevation: 5.0,
        child: ListTile(
          leading: leading,
          title: title,
          subtitle: subtitle,
          isThreeLine: true,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => BookPage(book),
              ),
            );
          },
        ),
      );
    };
  }
}
