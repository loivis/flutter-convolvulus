import 'dart:convert';

class Book {
  String author, chapterLink, id, image, intro, link, site, title, update;

  String get key => [this.site, this.author, this.title, this.id].join('_');

  Book(
    this.author,
    this.chapterLink,
    this.id,
    this.image,
    this.intro,
    this.link,
    this.site,
    this.title,
    this.update,
  );

  Book.fromJson(Map<String, dynamic> json)
      : author = json['author'],
        chapterLink = json['chapter_link'],
        id = json['id'],
        image = json['image'],
        intro = json['intro'],
        link = json['link'],
        site = json['site'],
        title = json['title'],
        update =
            json['update'] == null ? '2018-02-03T00:00:00Z' : json['update'];

  Map<String, dynamic> toJson() => {
        'author': author,
        'chapter_link': chapterLink,
        'id': id,
        'image': image,
        'intro': intro,
        'link': link,
        'site': site,
        'title': title,
        'update': update,
      };

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
