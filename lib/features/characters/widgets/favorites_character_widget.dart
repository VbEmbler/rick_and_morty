import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_and_morty/features/characters/favorites_character_bloc/favorites_character_bloc.dart';

class FavoritesCharacterWidget extends StatelessWidget {
  final int characterIndex;

  const FavoritesCharacterWidget({
    super.key,
    required this.characterIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCharacterBloc, FavoritesCharacterState>(
      builder: (context, state) {
        final bool isFavorite = state.favorites.contains(characterIndex);
        return InkWell(
          onTap: () {
            context
                .read<FavoritesCharacterBloc>()
                .add(FavoritesCharacterUpdateEvent(characterIndex));
          },
          child: Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              fit: BoxFit.fill,
              isFavorite ? 'assets/liked.svg' : 'assets/unliked.svg',
              height: 20,
              width: 20,
            ),
          ),
        );
      },
    );
  }
}
