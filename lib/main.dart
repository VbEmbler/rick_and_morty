import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty/rick_and_morty_app.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  runApp(const RickAndMortyApp());
}
