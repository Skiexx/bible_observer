import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

import 'api_settings.dart';

part 'book.g.dart';

@JsonSerializable()
class BookList {
  @JsonKey(name: 'data')
  final List<Book> books;

  BookList({required this.books});

  factory BookList.fromJson(Map<String, dynamic> json) =>
      _$BookListFromJson(json);

  Map<String, dynamic> toJson() => _$BookListToJson(this);
}

@JsonSerializable()
class Book {
  final String id;
  final String name;
  final String bibleId;

  Book(
      {required this.id, required this.name, required this.bibleId});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}

Future<BookList> fetchBooks(String bibleId) async {
  final response = await http.get(Uri.parse('$url/bibles/$bibleId/books'),
      headers: header);

  if (response.statusCode == 200) {
    return BookList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load book');
  }
}