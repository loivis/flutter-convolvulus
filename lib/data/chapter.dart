import 'dart:convert';

class Chapter {
  String link, site, text, title, update;

  Chapter(
    this.link,
    this.site,
    this.title,
    this.update,
  );

  Chapter.fromJson(Map<String, dynamic> json)
      : link = json['link'] == null ? json['chapter_link'] : json['link'],
        site = json['site'] == null ? '' : json['site'],
        text = json['text'] == null ? '' : json['text'],
        title = json['title'],
        update = json['update'];

  Map<String, dynamic> toJson() => {
        'link': link,
        'site': site,
        'text': text,
        'title': title,
        'update': update,
      };

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
