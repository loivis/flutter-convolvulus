import 'package:cached_network_image/cached_network_image.dart';
import 'package:convvls/data/book.dart';
import 'package:convvls/data/favorite.dart';
import 'package:convvls/model/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        if (model.favorite.length == 0) {
          model.readFavorite();
          return Center(
            child: Text('no favorite'),
          );
        }
        return _buildFavorite(model);
      },
    );
  }

  Widget _buildFavorite(MainModel model) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      itemCount: model.favorite.length * 2,
      itemBuilder: (BuildContext context, int index) {
        List<Favorite> favs = model.favorite.values.toList();

        if (index.isOdd) {
          return Divider(color: Theme.of(context).backgroundColor);
        }

        Favorite fav = favs[index ~/ 2];

        return ListTile(
          leading: CachedNetworkImage(
            imageUrl: fav.image,
            height: 75.0,
            placeholder: new CircularProgressIndicator(),
            errorWidget: new Icon(Icons.error),
          ),
          title: Text(fav.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${fav.author} | ${fav.site}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 250,
                    child: Text(
                      fav.latestChapter,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // show if there is update
                  Icon(Icons.new_releases, color: Colors.red, size: 15.0),
                ],
              ),
            ],
          ),
          onTap: () {}, // route to book reading
        );
      },
    );
  }
}
