import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

import 'api_settings.dart';

part 'chapter.g.dart';

@JsonSerializable()
class ChapterList {
  @JsonKey(name: 'data')
  final List<Chapter> chapters;

  ChapterList({required this.chapters});

  factory ChapterList.fromJson(Map<String, dynamic> json) =>
      _$ChapterListFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterListToJson(this);
}

@JsonSerializable()
class Chapter {
  final String id;
  final String number;
  final String? bibleId;
  final String bookId;

  Chapter(
      {required this.id,
      required this.number,
      required this.bibleId,
      required this.bookId});

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}

Future<ChapterList> fetchChapters(String bibleId, String bookId) async {
  final response = await http.get(
      Uri.parse('$url/bibles/$bibleId/books/$bookId/chapters'),
      headers: header);

  if (response.statusCode == 200) {
    return ChapterList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load chapter');
  }
}

@JsonSerializable()
class ChapterContent {
  final String id;
  final String bibleId;
  final String number;
  final String? content;
  final String? next;
  final String? previous;

  ChapterContent(
      {required this.id,
      required this.number,
      required this.bibleId,
      required this.content,
      required this.next,
      required this.previous,});

  factory ChapterContent.fromJson(Map<String, dynamic> json) => _$ChapterContentFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterContentToJson(this);
}

Future<ChapterContent> fetchChapterContent(String? bibleId, String? chapterId) async {
  final response = await http.get(
      Uri.parse('$url/bibles/$bibleId/chapters/$chapterId?content-type=text'),
      headers: header);

  if (response.statusCode == 200) {
    return ChapterContent.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load chapter');
  }
}