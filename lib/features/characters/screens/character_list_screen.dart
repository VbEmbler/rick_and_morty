import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/voids/voids.dart';
import 'package:rick_and_morty/features/characters/character_list_bloc/character_list_bloc.dart';
import 'package:rick_and_morty/features/characters/favorites_character_bloc/favorites_character_bloc.dart';
import 'package:rick_and_morty/features/characters/widgets/character_list_widget.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onInactive: () => _handleTransition(),
    );
    CharacterListBloc characterListBloc = context.read<CharacterListBloc>();
    characterListBloc.add(CharacterListInitEvent());
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  void _handleTransition() {
    context.read<FavoritesCharacterBloc>().add(FavoritesCharacterSaveEvent());
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double snackBarHeight = 40.0;
    final double snackBarPosition = screenHeight / 2 - snackBarHeight;

    return Scaffold(
      body: BlocListener<CharacterListBloc, CharacterListState>(
        listener: (context, state) {
          if (state is CharacterListErrorState) {
            showSnackBar(state, snackBarPosition, context);
          }
        },
        child: CharacterListWidget(),
      ),
    );
  }
}
