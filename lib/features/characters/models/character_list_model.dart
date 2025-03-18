import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/features/characters/models/character_model.dart';

import 'info_model.dart';

part 'character_list_model.g.dart';

@JsonSerializable()
class CharacterListModel {
  InfoModel? info;
  @JsonKey(name: 'results')
  List<CharacterModel>? characterList;

  CharacterListModel({this.info, this.characterList});

  factory CharacterListModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterListModelFromJson(json);
}
