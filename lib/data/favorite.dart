import 'package:convvls/data/book.dart';

class Favorite extends Book {
  String source;
  String latestChapter;

  Favorite.fromJson(Map<String, dynamic> json)
      : latestChapter = "┗|｀O′|┛ 嗷~~",
        super.fromJson(json);
}
