// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookList _$BookListFromJson(Map<String, dynamic> json) => BookList(
      books: (json['data'] as List<dynamic>)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookListToJson(BookList instance) => <String, dynamic>{
      'data': instance.books,
    };

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: json['id'] as String,
      name: json['name'] as String,
      bibleId: json['bibleId'] as String,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bibleId': instance.bibleId,
    };
