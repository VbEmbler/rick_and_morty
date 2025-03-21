part of 'character_details_bloc.dart';

abstract class CharacterDetailsEvent {}

final class CharacterInfoInitEvent extends CharacterDetailsEvent {
  int characterId;
  CharacterInfoInitEvent({required this.characterId});
}
