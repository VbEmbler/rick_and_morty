// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterModel _$CharacterModelFromJson(Map<String, dynamic> json) =>
    CharacterModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
      species: $enumDecodeNullable(_$SpeciesEnumMap, json['species']),
      type: json['type'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      origin: json['origin'] == null
          ? null
          : OriginModel.fromJson(json['origin'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      image: json['image'] as String?,
      episode:
          (json['episode'] as List<dynamic>?)?.map((e) => e as String).toList(),
      url: json['url'] as String?,
      created: json['created'] as String?,
    );

Map<String, dynamic> _$CharacterModelToJson(CharacterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': _$StatusEnumMap[instance.status],
      'species': _$SpeciesEnumMap[instance.species],
      'type': instance.type,
      'gender': _$GenderEnumMap[instance.gender],
      'origin': instance.origin,
      'location': instance.location,
      'image': instance.image,
      'episode': instance.episode,
      'url': instance.url,
      'created': instance.created,
    };

const _$StatusEnumMap = {
  Status.alive: 'Alive',
  Status.dead: 'Dead',
  Status.unknown: 'unknown',
};

const _$SpeciesEnumMap = {
  Species.alien: 'Alien',
  Species.human: 'Human',
  Species.humanoid: 'Humanoid',
  Species.unknown: 'unknown',
  Species.poopybutthole: 'Poopybutthole',
  Species.mythologicalCreature: 'Mythological Creature',
  Species.animal: 'Animal',
  Species.robot: 'Robot',
  Species.cronenberg: 'Cronenberg',
  Species.disease: 'Disease',
};

const _$GenderEnumMap = {
  Gender.male: 'Male',
  Gender.female: 'Female',
  Gender.unknown: 'unknown',
  Gender.genderless: 'Genderless',
};
