import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/features/characters/models/location_model.dart';
import 'package:rick_and_morty/features/characters/models/origin_model.dart';

part 'character_model.g.dart';

@JsonSerializable()
class CharacterModel {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  OriginModel? origin;
  LocationModel? location;
  String? image;
  List<String>? episode;
  String? url;
  String? created;

  CharacterModel({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);
}
