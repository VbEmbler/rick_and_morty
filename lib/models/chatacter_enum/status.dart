import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/res/project_icons.dart';

@JsonEnum(fieldRename: FieldRename.pascal)
enum Status {
  alive,
  dead,
  @JsonValue('unknown')
  unknown;

  String get statusUpperCase => switch (this) {
        Status.alive => 'Alive',
        Status.dead => 'Dead',
        Status.unknown => 'unknown',
      };

  String get statusIcon => switch (this) {
        Status.alive => ProjectIcons.alive,
        Status.dead => ProjectIcons.dead,
        Status.unknown => ProjectIcons.unknownStatus,
      };
}
