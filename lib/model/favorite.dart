import 'dart:async';
import 'dart:convert';
import 'package:convvls/data/book.dart';
import 'package:convvls/data/favorite.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteModel extends Model {
  // _prefs saves _favorite
  SharedPreferences _prefs;

  Map<String, Favorite> _favorite = {};
  Map<String, Favorite> get favorite => _favorite;

  readFavorite() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }

    String favString = _prefs.getString('favorite');
    print('favString from shared preferences: "$favString"');

    if (favString != null) {
      Map<String, dynamic> favJson = json.decode(favString);
      favJson.forEach((k, v) {
        Favorite fav = Favorite.fromJson(v);
        _favorite.addAll({fav.key: fav});
      });

      if (_favorite.keys.length == 0) {
        return;
      }

      notifyListeners();
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

    Favorite fav = book as Favorite;
    print('add "${fav.key}" to favorite');
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
