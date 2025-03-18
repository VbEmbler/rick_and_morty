import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/voids/voids.dart';
import 'package:rick_and_morty/features/characters/character_list_bloc/character_list_bloc.dart';
import 'package:rick_and_morty/features/characters/widgets/character_list_widget.dart';
import 'package:rick_and_morty/features/characters/widgets/error_getting_data_widget.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //get snackBar Position
    final double screenHeight = MediaQuery.of(context).size.height;
    final double snackBarHeight = 40.0;
    final double snackBarPosition = screenHeight / 2 - snackBarHeight;

    CharacterListBloc characterListBloc = context.read<CharacterListBloc>();
    characterListBloc.add(CharacterListInitEvent());

    return Scaffold(
      body: BlocListener<CharacterListBloc, CharacterListState>(
        listener: (context, state) {
          if (state is CharacterListErrorState) {
            showSnackBar(state, snackBarPosition, context);
            ErrorGettingDataWidget();
          }
        },
        child: CharacterListWidget(),
      ),
    );
  }
}
