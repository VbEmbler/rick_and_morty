import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/models/chatacter_enum/gender.dart';
import 'package:rick_and_morty/models/chatacter_enum/species.dart';
import 'package:rick_and_morty/models/chatacter_enum/status.dart';
import 'package:rick_and_morty/models/location_model.dart';
import 'package:rick_and_morty/models/origin_model.dart';

part 'character_model.g.dart';

@JsonSerializable()
class CharacterModel {
  int id;
  String? name;
  Status? status;
  Species? species;
  String? type;
  Gender? gender;
  OriginModel? origin;
  LocationModel? location;
  String? image;
  List<String>? episode;
  String? url;
  String? created;

  CharacterModel({
    required this.id,
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

  factory CharacterModel.fromJson(Map<String, dynamic> json) => _$CharacterModelFromJson(json);
}
