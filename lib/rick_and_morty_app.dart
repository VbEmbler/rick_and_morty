import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty/data/api/characters_api.dart';
import 'package:rick_and_morty/data/local_database/shared_preferences_utils.dart';
import 'package:rick_and_morty/data/network/network_info.dart';
import 'package:rick_and_morty/language_utils.dart';
import 'package:rick_and_morty/repositories/characters_remote_repository.dart';
import 'package:rick_and_morty/repositories/characters_shared_pref_repository.dart';
import 'package:rick_and_morty/screens/character_list/character_list_bloc.dart';
import 'package:rick_and_morty/screens/character_list/character_list_screen.dart';
import 'package:rick_and_morty/screens/characters_details/character_details_bloc.dart';
import 'package:rick_and_morty/screens/characters_details/character_details_screen.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CharacterSharedPrefRepository>(
          create: (context) => CharacterSharedPrefRepository(
            characterFavoritesUtil: SharedPreferencesUtils(),
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
          BlocProvider<CharacterListBloc>(
            create: (context) => CharacterListBloc(
              charactersRemoteRepository:
                  context.read<CharactersRemoteRepository>(),
              sharedPreferencesUtil: SharedPreferencesUtils(),
            )..add(CharacterListGetFavoritesEvent()),
            lazy: false,
          ),
          BlocProvider<CharacterDetailsBloc>(
            create: (context) => CharacterDetailsBloc(
                charactersRemoteRepository:
                    context.read<CharactersRemoteRepository>()),
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
                fontFamily: 'Lato',
                fontSize: 14,
                height: 1.4,
              ),
              bodyMedium: TextStyle(
                fontFamily: 'Lato',
                fontSize: 16,
                height: 1.4,
                fontWeight: FontWeight.bold,
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
        routes: [
          GoRoute(
              path: 'character_info',
              builder: (BuildContext context, GoRouterState state) {
                return const CharacterDetailsScreen();
              }),
        ])
  ],
);
