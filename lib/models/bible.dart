import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'api_settings.dart';

part 'bible.g.dart';

@JsonSerializable()
class BibleList {
  @JsonKey(name: 'data')
  final List<Bible> bible;

  BibleList({required this.bible});

  factory BibleList.fromJson(Map<String, dynamic> json) =>
      _$BibleListFromJson(json);

  Map<String, dynamic> toJson() => _$BibleListToJson(this);
}

@JsonSerializable()
class Bible {
  final String id;
  final String name;
  final String? description;
  final String? language;

  Bible(
      {required this.id,
      required this.name,
      required this.description,
      required this.language});

  factory Bible.fromJson(Map<String, dynamic> json) => _$BibleFromJson(json);

  Map<String, dynamic> toJson() => _$BibleToJson(this);
}

Future<BibleList> fetchBible() async {
  final response = await http.get(Uri.parse('$url/bibles'), headers: header);

  if (response.statusCode == 200) {
    return BibleList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load bible');
  }
}
