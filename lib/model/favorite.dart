import 'dart:async';
import 'dart:convert';
import 'package:convvls/data/book.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteModel extends Model {
  // _prefs saves _favorite
  SharedPreferences _prefs;

  Map<String, Book> _favorite = {};
  Map<String, Book> get favorite => _favorite;

  readFavorite() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }

    var favString = _prefs.getString('favorite');
    print('favString from shared preferences: "$favString"');
    if (favString != null) {
      Map<String, dynamic> favJson = json.decode(favString);
      favJson.forEach((k, v) {
        var book = Book.fromJson(v);
        _favorite.addAll({book.key: book});
      });
      notifyListeners();
    }
  }

  bool isFavorite(String key) {
    var keys = _favorite.keys;
    print('check favorite: $key');
    print('${keys.length} books in favorite: $keys');
    if (keys.contains(key)) {
      return true;
    }
    return false;
  }

  Future addFavorite(Book book) async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }

    print('add "${book.key}" to favorite');
    _favorite.addAll({book.key: book});
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
