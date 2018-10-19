import 'package:cached_network_image/cached_network_image.dart';
import 'package:convvls/data/favorite.dart';
import 'package:convvls/model/main.dart';
import 'package:convvls/screen/text.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildFavorite(),
      floatingActionButton: _buildFAB(),
    );
  }

  ScopedModelDescendant<MainModel> _buildFavorite() {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      if (model.favorite.length == 0) {
        model.refreshFavorite();
        return Center(
          child: Text('no favorite'),
        );
      }

      var itemBuilder = (BuildContext context, int index) {
        List<Favorite> favs = model.favorite.values.toList();

        if (index.isOdd) {
          return Divider(color: Theme.of(context).backgroundColor);
        }

        Favorite fav = favs[index ~/ 2];

        CachedNetworkImage leading = CachedNetworkImage(
          imageUrl: fav.image,
          height: 75.0,
          placeholder: new CircularProgressIndicator(),
          errorWidget: new Icon(Icons.error),
        );

        Icon updateIndicator = fav.sources[fav.source].length > fav.progress
            ? Icon(Icons.bookmark_border, color: Colors.grey, size: 15.0)
            : Icon(Icons.bookmark, color: Colors.red, size: 15.0);

        Column subtitle = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${fav.author} | ${fav.site}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 250,
                  child: Text(
                    fav.latestChapter == null ? 'n/a' : fav.latestChapter,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                updateIndicator,
              ],
            ),
          ],
        );

        return ListTile(
          leading: leading,
          title: Text(fav.title),
          subtitle: subtitle,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => TextPage(fav),
              ),
            );
          },
          onLongPress: () {
            model.removeFavorite(fav.key);
          },
        );
      };

      return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        itemCount: model.favorite.length * 2,
        itemBuilder: itemBuilder,
      );
    });
  }

  _buildFAB() {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return FloatingActionButton(
        child: model.refreshFav
            ? CircularProgressIndicator()
            : Icon(Icons.refresh),
        // child: CircularProgressIndicator(),
        onPressed: () => model.refreshFavorite(),
      );
    });
  }
}
