import 'dart:convert';

import 'package:convvls/data/book.dart';
import 'package:http/http.dart' as http;

class Search {
  Search();

  Future<List<Book>> get(String keywords) async {
    List<Book> _books = [];

    String url = 'https://convvls.herokuapp.com/search?keywords=' + keywords;
    print(url);
    final resp = await http.get(url);
    if (resp.statusCode != 200) {
      print('failed to search "$keywords" from backend');
      return _books;
    }

    json.decode(resp.body).forEach((item) {
      _books.add(Book.fromJson(item));
    });

    print('return ${_books.length} results from backend for "$keywords"');
    return _books;
  }
}
