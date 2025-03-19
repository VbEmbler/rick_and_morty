part of 'character_list_bloc.dart';

abstract class CharacterListEvent {}

final class CharacterListInitEvent extends CharacterListEvent {}

final class CharacterListFetchEvent extends CharacterListEvent {}
