import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  String author, chapterLink, id, image, intro, link, site, title;

  @JsonKey(defaultValue: '2018-02-03')
  String update;

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

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  // Book.fromJson(Map<String, dynamic> json)
  //     : author = json['author'],
  //       chapterLink = json['chapter_link'],
  //       id = json['id'],
  //       image = json['image'],
  //       intro = json['intro'],
  //       link = json['link'],
  //       site = json['site'],
  //       title = json['title'],
  //       update = json['update'] ?? '2018-02-03T00:00:00Z';

  // Map<String, dynamic> toJson() => {
  //       'author': author,
  //       'chapter_link': chapterLink,
  //       'id': id,
  //       'image': image,
  //       'intro': intro,
  //       'link': link,
  //       'site': site,
  //       'title': title,
  //       'update': update,
  //     };

  // @override
  // String toString() {
  //   return json.encode(this.toJson());
  // }
}
