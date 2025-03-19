import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/voids/voids.dart';
import 'package:rick_and_morty/features/characters/character_info_bloc/character_info_bloc.dart';
import 'package:rick_and_morty/features/characters/character_list_bloc/character_list_bloc.dart';
import 'package:rick_and_morty/features/characters/models/character_model.dart';
import 'package:rick_and_morty/features/characters/widgets/character_info_widget.dart';
import 'package:rick_and_morty/features/characters/widgets/error_getting_data_widget.dart';

class CharacterInfoScreen extends StatelessWidget {
  const CharacterInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double snackBarHeight = 40.0;
    final double snackBarPosition = screenHeight / 2 - snackBarHeight;

    return Scaffold(
      body: BlocListener<CharacterInfoBloc, CharacterInfoState>(
        listener: (context, state) {
          if (state is CharacterInfoErrorState) {
            showSnackBar(state, snackBarPosition, context);
          }
        },
        child: BlocBuilder<CharacterInfoBloc, CharacterInfoState>(
          builder: (context, state) {
            if (state is CharacterInfoInitState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CharacterInfoLoadedState) {
              CharacterModel character = state.characterModel;
              return CharacterInfoWidget(character: character);
            } else if (state is CharacterListErrorState) {
              return const ErrorGettingDataWidget();
            }
            return Placeholder();
          },
        ),
      ),
    );
  }
}
