import 'package:convvls/data/book.dart';

class Favorite extends Book {
  int progress;
  String latestChapter, source;
  DateTime update;

  Favorite.fromJson(Map<String, dynamic> json)
      : source = json["site"],
        progress = 0,
        super.fromJson(json);
}
