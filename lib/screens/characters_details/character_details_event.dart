abstract class CharacterDetailsEvent {}

final class CharacterDetailsInitEvent extends CharacterDetailsEvent {
  int characterId;
  CharacterDetailsInitEvent({required this.characterId});
}
