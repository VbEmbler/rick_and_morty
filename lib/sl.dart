import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/data/api/characters_api.dart';
import 'package:rick_and_morty/repositories/character_repository.dart';
import 'package:rick_and_morty/screens/character_list/character_list_bloc.dart';
import 'package:rick_and_morty/screens/characters_details/character_details_bloc.dart';

import 'data/prefs/prefs.dart';

final sl = GetIt.I;

void initLocator() {
  //data
  sl.registerLazySingleton<CharactersApi>(() => CharactersApi());
  sl.registerLazySingleton<Prefs>(() => Prefs());

  //repositories
  sl.registerSingleton<CharacterRepository>(CharacterRepository(
    charactersApi: sl<CharactersApi>(),
    prefs: sl<Prefs>(),
  ));

  //bloc
  sl.registerSingleton<CharacterListBloc>(
    CharacterListBloc(
      characterRepository: sl<CharacterRepository>(),
    ),
  );
  sl.registerSingleton<CharacterDetailsBloc>(
    CharacterDetailsBloc(
      characterRepository: sl<CharacterRepository>(),
    ),
  );
}
