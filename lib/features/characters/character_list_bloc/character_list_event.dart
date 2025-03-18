part of 'character_list_bloc.dart';

abstract class CharacterListEvent {}

class CharacterListInitEvent extends CharacterListEvent {}

class CharacterListFetchEvent extends CharacterListEvent {}
