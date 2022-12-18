// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BibleList _$BibleListFromJson(Map<String, dynamic> json) => BibleList(
      bible: (json['data'] as List<dynamic>)
          .map((e) => Bible.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BibleListToJson(BibleList instance) => <String, dynamic>{
      'data': instance.bible,
    };

Bible _$BibleFromJson(Map<String, dynamic> json) => Bible(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      language: json['language']['name'] as String?,
    );

Map<String, dynamic> _$BibleToJson(Bible instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'language': instance.language,
    };
