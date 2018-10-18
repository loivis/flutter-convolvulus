import 'dart:convert';

class Book {
  String author, chapterLink, id, image, intro, link, site, title;
  DateTime update;

  String get key => this.site + this.author + this.title + this.id;

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
        chapterLink = json['chapterLink'],
        id = json['id'],
        image = json['image'],
        intro = json['intro'],
        site = json['site'],
        title = json['title'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'site': site,
        'link': link,
        'author': author,
        'introduction': intro,
        'image': image,
        'chapterLink': chapterLink,
        'update': update,
      };

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
