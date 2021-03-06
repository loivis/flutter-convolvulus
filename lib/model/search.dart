import 'package:convvls/model/book.dart';
import 'package:convvls/data/search.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchModel extends Model {
  // _prefs saves _searchHistory
  static SharedPreferences _prefs;

  List<Book> _books = [];
  List<Book> get searchResult => _books;

  String _progress = 'ready';
  String get searchProgress => _progress;

  List<String> _searchHistory = [];
  List<String> get searchHistory => _searchHistory;

  Future startSearch(String keywords) async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }

    keywords = keywords.trim();
    print('start searching on "$keywords"');
    _progress = 'inprogress';
    notifyListeners();

    if (_searchHistory.contains(keywords)) {
      _searchHistory.remove(keywords);
    }
    print('add "$keywords" to search history');
    _searchHistory.insert(0, keywords);
    _prefs.setStringList('searchHistory', _searchHistory);

    _books = await Search().keywords(keywords);
    _progress = 'done';
    print('search model returns ${_books.length} results for "$keywords"');

    notifyListeners();
  }

  void resetSearch() {
    _progress = 'ready';
    _books = [];
    notifyListeners();
  }

  readSearchHistory() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }

    print('read search history');
    List<String> saved = _prefs.getStringList('searchHistory');
    print('saved search history: $saved');
    if (saved == null || saved.length == 0) {
      return;
    }

    _searchHistory = saved;

    notifyListeners();
  }

  void removeFromSearchHistory(int i) async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }

    print('remove "${_searchHistory[i]}" from search history');
    _searchHistory.removeAt(i);
    _prefs.setStringList('searchHistory', _searchHistory);

    notifyListeners();
  }

  void resetSearchHistory() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }

    print('reset search history');
    _prefs.remove('searchHistory');
    _searchHistory = [];

    notifyListeners();
  }
}
