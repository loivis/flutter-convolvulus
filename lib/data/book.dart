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

  Book.fromFavorite(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        site = json['site'],
        image = json['image'],
        chapterLink = json['chapterLink'];

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
