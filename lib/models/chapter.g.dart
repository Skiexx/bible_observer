// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterList _$ChapterListFromJson(Map<String, dynamic> json) => ChapterList(
      chapters: (json['data'] as List<dynamic>)
          .map((e) => Chapter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChapterListToJson(ChapterList instance) =>
    <String, dynamic>{
      'data': instance.chapters,
    };

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter(
      id: json['id'] as String,
      number: json['number'] as String,
      bibleId: json['bibleId'] as String?,
      bookId: json['bookId'] as String,
    );

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'bibleId': instance.bibleId,
      'bookId': instance.bookId,
    };

ChapterContent _$ChapterContentFromJson(Map<String, dynamic> json) => ChapterContent(
  id: json['data']['id'] as String,
  number: json['data']['number'] as String,
  bibleId: json['data']['bibleId'] as String,
  content: json['data']['content'] as String,
  next: json['data']?['next']?['id'] as String?,
  previous: json['data']?['previous']?['id'] as String?,
);

Map<String, dynamic> _$ChapterContentToJson(ChapterContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bibleId': instance.bibleId,
      'number': instance.number,
      'content': instance.content,
      'next': instance.next,
      'previous': instance.previous,
    };
