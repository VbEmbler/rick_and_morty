import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/res/project_icons.dart';

@JsonEnum(fieldRename: FieldRename.pascal)
enum Gender {
  male,
  female,
  @JsonValue('unknown')
  unknown,
  genderless;

  String get genderUpperCase => switch (this) {
        Gender.male => 'Male',
        Gender.female => 'Female',
        Gender.unknown => 'unknown',
        Gender.genderless => 'Genderless',
      };

  String get genderIcon => switch (this) {
        Gender.female => ProjectIcons.female,
        Gender.male => ProjectIcons.male,
        _ => ProjectIcons.unknownGender,
      };
}
