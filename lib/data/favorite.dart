import 'dart:convert';
import 'package:convvls/data/book.dart';
import 'package:convvls/data/chapter.dart';

class Favorite extends Book {
  int progress;
  String latestChapter, source;
  Map<String, List<Chapter>> sources;

  Favorite.fromJson(Map<String, dynamic> json)
      : latestChapter =
            json['latest_chapter'] == null ? 'n/a' : json['latest_chapter'],
        progress = json['progress'] == null ? 0 : json['progress'],
        source = json['source'] == null ? json['site'] : json['source'],
        sources = {},
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        'author': author,
        'chapter_link': chapterLink,
        'id': id,
        'image': image,
        'intro': intro,
        'link': link,
        'progress': progress,
        'site': site,
        'source': source,
        'title': title,
        'update': update,
      };

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
