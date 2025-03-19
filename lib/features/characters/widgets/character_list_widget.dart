import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/characters/character_list_bloc/character_list_bloc.dart';
import 'package:rick_and_morty/features/characters/models/character_list_model.dart';
import 'package:rick_and_morty/features/characters/widgets/error_getting_data_widget.dart';

import 'character_grid_view_widget.dart';

class CharacterListWidget extends StatefulWidget {
  const CharacterListWidget({super.key});

  @override
  State<CharacterListWidget> createState() => _CharacterListWidgetState();
}

class _CharacterListWidgetState extends State<CharacterListWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    CharacterListState characterListState =
        context.read<CharacterListBloc>().state;
    if (characterListState is CharacterListLoadedState) {
      if (_isBottom && !characterListState.isFetch) {
        context.read<CharacterListBloc>().add(CharacterListFetchEvent());
      }
    }
  }

  bool get _isBottom {
    return _scrollController.position.extentAfter < 100;
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final double paddingTop = statusBarHeight + 20;
    return BlocBuilder<CharacterListBloc, CharacterListState>(
      builder: (context, state) {
        if (state is CharacterListInitState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CharacterListLoadedState) {
          CharacterListModel characters = state.characterListModel;
          return CharacterGridViewWidget(
            paddingTop: paddingTop,
            scrollController: _scrollController,
            characters: characters,
            state: state,
          );
        } else if (state is CharacterListErrorState) {
          return const ErrorGettingDataWidget();
        }
        return Placeholder();
      },
    );
  }
}
