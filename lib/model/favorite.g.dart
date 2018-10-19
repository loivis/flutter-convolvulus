// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorite _$FavoriteFromJson(Map<String, dynamic> json) {
  return Favorite(
      json['author'],
      json['chapterLink'],
      json['id'],
      json['image'],
      json['intro'],
      json['link'],
      json['site'],
      json['title'],
      json['update'] ?? '2018-02-03',
      json['progress'] as int,
      json['latestChapter'] as String,
      (json['sources'] as Map<String, dynamic>)?.map((k, e) => MapEntry(
          k,
          (e as List)
              ?.map((e) => e == null
                  ? null
                  : Chapter.fromJson(e as Map<String, dynamic>))
              ?.toList())))
    ..source = json['source'] as String;
}

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
      'author': instance.author,
      'chapterLink': instance.chapterLink,
      'id': instance.id,
      'image': instance.image,
      'intro': instance.intro,
      'link': instance.link,
      'site': instance.site,
      'title': instance.title,
      'update': instance.update,
      'progress': instance.progress,
      'latestChapter': instance.latestChapter,
      'source': instance.source,
      'sources': instance.sources
    };
