import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/data/api/characters_api.dart';
import 'package:rick_and_morty/data/prefs/prefs.dart';
import 'package:rick_and_morty/language_utils.dart';
import 'package:rick_and_morty/repositories/character_repository.dart';
import 'package:rick_and_morty/res/project_colors.dart';
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
        RepositoryProvider<CharacterRepository>(
          create: (context) => CharacterRepository(
            charactersApi: CharactersApi(),
            prefs: Prefs(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CharacterListBloc>(
            create: (context) => CharacterListBloc(
              characterRepository: context.read<CharacterRepository>(),
            ),
          ),
          BlocProvider<CharacterDetailsBloc>(
            create: (context) => CharacterDetailsBloc(characterRepository: context.read<CharacterRepository>()),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: LanguageUtils.applicationName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: ProjectColors.whiteSmoke,
              primary: ProjectColors.irisBlue,
              onPrimary: ProjectColors.white,
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
