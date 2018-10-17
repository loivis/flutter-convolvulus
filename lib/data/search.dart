import 'package:convvls/data/book.dart';

class Search {
  List<Book> books = [];
  String keywords;

  Search(this.keywords);

  Future<List<Book>> get() async {
    var books = <Book>[];
    var results = await Future.wait([]);
    for (var r in results) {
      books.addAll(r);
    }
    return books;
  }
}
