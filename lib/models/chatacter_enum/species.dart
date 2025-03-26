import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/res/project_icons.dart';

@JsonEnum(fieldRename: FieldRename.pascal)
enum Species {
  alien,
  human,
  humanoid,
  @JsonValue('unknown')
  unknown,
  poopybutthole,
  @JsonValue('Mythological Creature')
  mythologicalCreature,
  animal,
  robot,
  cronenberg,
  disease;

  String get speciesUpperCase => switch (this) {
        Species.alien => 'Alien',
        Species.human => 'Human',
        Species.humanoid => 'Humanoid',
        Species.unknown => 'unknown',
        Species.poopybutthole => 'Poopybutthole',
        Species.mythologicalCreature => 'Mythological Creature',
        Species.animal => 'Animal',
        Species.robot => 'Robot',
        Species.cronenberg => 'Cronenberg',
        Species.disease => 'Disease',
      };

  String get speciesIcon => switch (this) {
        Species.human => ProjectIcons.human,
        Species.alien => ProjectIcons.alien,
        _ => ProjectIcons.unknownSpecies
      };
}
