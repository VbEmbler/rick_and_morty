import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/data/api/characters_api.dart';
import 'package:rick_and_morty/repositories/character_repository.dart';
import 'package:rick_and_morty/screens/character_list/character_list_bloc.dart';
import 'package:rick_and_morty/screens/characters_details/character_details_bloc.dart';

import 'data/prefs/prefs.dart';

final getIt = GetIt.I;

void initLocator() {
  //data
  getIt.registerSingleton<CharactersApi>(CharactersApi());
  getIt.registerSingleton<Prefs>(Prefs());

  //repositories
  getIt.registerSingleton<CharacterRepository>(CharacterRepository(
    charactersApi: getIt<CharactersApi>(),
    prefs: getIt<Prefs>(),
  ));

  //bloc
  getIt.registerFactory<CharacterListBloc>(() {
    return CharacterListBloc(
      characterRepository: getIt<CharacterRepository>(),
    );
  });

  getIt.registerFactory<CharacterDetailsBloc>(() {
    return CharacterDetailsBloc(
      characterRepository: getIt<CharacterRepository>(),
    );
  });
}
