import 'dart:convert';

class Chapter {
  String link, title;
  DateTime update;

  Chapter(
    this.link,
    this.title,
    this.update,
  );

  Chapter.fromJson(Map<String, dynamic> json)
      : link = json['link'],
        title = json['title'],
        update = DateTime.parse(json['update']);

  Map<String, dynamic> toJson() => {
        'link': link,
        'title': title,
        'update': update,
      };

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
