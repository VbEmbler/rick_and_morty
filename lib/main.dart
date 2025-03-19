import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty/features/characters/src/local_database/character_favorites_util.dart';
import 'package:rick_and_morty/rick_and_morty_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await CharacterFavoritesUtil.init();

  runApp(const RickAndMortyApp());
}
