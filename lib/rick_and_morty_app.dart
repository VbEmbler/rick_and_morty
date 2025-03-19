import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty/core/platform/network_info.dart';
import 'package:rick_and_morty/core/utils/language_utils.dart';
import 'package:rick_and_morty/features/characters/character_list_bloc/character_list_bloc.dart';
import 'package:rick_and_morty/features/characters/favorites_character_bloc/favorites_character_bloc.dart';
import 'package:rick_and_morty/features/characters/screens/character_list_screen.dart';
import 'package:rick_and_morty/features/characters/src/api/characters_api.dart';
import 'package:rick_and_morty/features/characters/src/local_database/character_favorites_util.dart';
import 'package:rick_and_morty/features/characters/src/repositories/characters_favorites_repository.dart';
import 'package:rick_and_morty/features/characters/src/repositories/characters_remote_repository.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CharacterFavoritesRepository>(
          create: (context) => CharacterFavoritesRepository(
            characterFavoritesUtil: CharacterFavoritesUtil(),
          ),
        ),
        RepositoryProvider<CharactersRemoteRepository>(
          create: (context) => CharactersRemoteRepository(
            charactersApi: CharactersApi(),
            networkInfo: NetworkInfo(InternetConnectionChecker.instance),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FavoritesCharacterBloc>(
            create: (context) => FavoritesCharacterBloc(
              characterFavoritesUtil: CharacterFavoritesUtil(),
            )..add(FavoritesCharacterInitEvent()),
            lazy: false,
          ),
          BlocProvider<CharacterListBloc>(
            create: (context) => CharacterListBloc(
              charactersRemoteRepository:
                  context.read<CharactersRemoteRepository>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: LanguageUtils.applicationName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color(0xFFF8F8F8),
              primary: Color(0xFF11B0C8),
              onPrimary: Colors.white,
            ),
            textTheme: TextTheme(
              bodyLarge: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
              bodyMedium: TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
          routerConfig: _router,
        ),
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const CharacterListScreen();
      },
    )
  ],
);
