part of 'character_info_bloc.dart';

abstract class CharacterInfoEvent {}

final class CharacterInfoInitEvent extends CharacterInfoEvent {
  int characterId;
  CharacterInfoInitEvent({required this.characterId});
}
