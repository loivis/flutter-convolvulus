import 'dart:async';
import 'dart:convert';
import 'package:convvls/data/book.dart';
import 'package:convvls/data/chapter.dart';
import 'package:convvls/data/chapters.dart';
import 'package:convvls/data/favorite.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteModel extends Model {
  // _prefs saves _favorite
  SharedPreferences _prefs;

  bool refreshFav = false;

  Map<String, Favorite> _favorite = {};
  Map<String, Favorite> get favorite => _favorite;

  refreshFavorite() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }

    refreshFav = true;

    String favString = _prefs.getString('favorite');
    print('favString from shared preferences: "$favString"');

    Map<String, dynamic> favJson = json.decode(favString);
    favJson.forEach((k, v) async {
      Favorite fav = Favorite.fromJson(v);
      Chapter latest = await Chapters().latest(fav.source, fav.title);
      if (latest != null) {
        fav.latestChapter = latest.title;
        print(fav.latestChapter);
        print(fav);
      }

      _favorite.addAll({fav.key: fav});
      print('set favorites: $_favorite');
      _prefs.setString('favorite', json.encode(_favorite));

      notifyListeners();
    });

    refreshFav = false;

    if (_favorite.keys.length == 0) {
      return;
    }
  }

  bool isFavorite(String key) {
    Iterable<String> keys = _favorite.keys;
    print('check favorite: $key');
    print('${keys.length} favorite: $keys');
    if (keys.contains(key)) {
      return true;
    }
    return false;
  }

  Future addFavorite(Book book) async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }

    Favorite fav = Favorite.fromJson(book.toJson());
    print('add "${fav.key}" to favorites: $fav');
    _favorite.addAll({fav.key: fav});
    _prefs.setString('favorite', json.encode(_favorite));

    notifyListeners();
  }

  Future removeFavorite(String key) async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }

    print('remove "$key" from favorite');
    _favorite.remove(key);
    _prefs.setString('favorite', _favorite.toString());
    notifyListeners();
  }
}
