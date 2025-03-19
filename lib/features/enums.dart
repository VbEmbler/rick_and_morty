enum CharacterSpecies {
  human,
  alien;

  String get text {
    switch (this) {
      case CharacterSpecies.human:
        return 'human';
      case CharacterSpecies.alien:
        return 'alien';
    }
  }
}

enum CharacterStatus {
  alive,
  unknown,
  dead;

  String get text {
    switch (this) {
      case CharacterStatus.alive:
        return 'alive';
      case CharacterStatus.unknown:
        return 'unknown';
      case CharacterStatus.dead:
        return 'dead';
    }
  }
}

enum CharacterGender {
  male,
  female,
  unknown;

  String get text {
    switch (this) {
      case CharacterGender.male:
        return 'male';
      case CharacterGender.female:
        return 'female';
      case CharacterGender.unknown:
        return 'unknown';
    }
  }
}
