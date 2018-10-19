import 'dart:convert';

import 'package:convvls/data/book.dart';
import 'package:convvls/data/chapter.dart';
import 'package:http/http.dart' as http;

class Search {
  Search();

  Future<List<String>> name(String name) async {
    List<String> _sites = [];

    String url = 'https://convvls.herokuapp.com/search?book_name=' + name;
    print(url);
    final resp = await http.get(url);
    if (resp.statusCode != 200) {
      print('failed to search "$name" by name from backend');
      return _sites;
    }

    json.decode(resp.body).forEach((item) {
      Chapter c = Chapter.fromJson(item);
      _sites.add(c.site);
    });

    print(
        'name search returns ${_sites.length} sites from backend for "$name"');
    return _sites;
  }

  Future<List<Book>> keywords(String keywords) async {
    List<Book> _books = [];

    String url = 'https://convvls.herokuapp.com/search?keywords=' + keywords;
    print(url);
    final resp = await http.get(url);
    if (resp.statusCode != 200) {
      print('failed to search "$keywords" by keywords from backend');
      return _books;
    }

    json.decode(resp.body).forEach((item) {
      Book book = Book.fromJson(item);
      _books.add(book);
    });

    print(
        'keywords search returns ${_books.length} books from backend for "$keywords"');
    return _books;
  }
}
