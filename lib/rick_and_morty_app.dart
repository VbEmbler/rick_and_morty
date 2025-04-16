import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/language_utils.dart';
import 'package:rick_and_morty/res/project_colors.dart';
import 'package:rick_and_morty/screens/character_list/character_list_screen.dart';
import 'package:rick_and_morty/screens/characters_details/character_details_screen.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
              path: 'character_info/:character_id',
              builder: (BuildContext context, GoRouterState state) {
                final int characterId = int.parse(state.pathParameters['character_id']!);
                return CharacterDetailsScreen(characterId: characterId);
              }),
        ])
  ],
);
