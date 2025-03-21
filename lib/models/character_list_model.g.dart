// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterListModel _$CharacterListModelFromJson(Map<String, dynamic> json) =>
    CharacterListModel(
      info:
          json['info'] == null
              ? null
              : InfoModel.fromJson(json['info'] as Map<String, dynamic>),
      characterList:
          (json['results'] as List<dynamic>?)
              ?.map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$CharacterListModelToJson(CharacterListModel instance) =>
    <String, dynamic>{'info': instance.info, 'results': instance.characterList};
