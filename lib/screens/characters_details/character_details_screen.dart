import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/language_utils.dart';
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/screens/character_list/character_list_bloc.dart';
import 'package:rick_and_morty/screens/characters_details/character_details_bloc.dart';
import 'package:rick_and_morty/voids.dart';
import 'package:rick_and_morty/widgets/error_getting_data_widget.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double snackBarHeight = 40.0;
    final double snackBarPosition = screenHeight / 2 - snackBarHeight;

    return Scaffold(
      body: BlocListener<CharacterDetailsBloc, CharacterDetailsState>(
        listener: (context, state) {
          if (state is CharacterDetailsErrorState) {
            showSnackBar(state, snackBarPosition, context);
          }
        },
        child: BlocBuilder<CharacterDetailsBloc, CharacterDetailsState>(
          builder: (context, state) {
            if (state is CharacterDetailsInitState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CharacterDetailsLoadedState) {
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

class CharacterInfoWidget extends StatelessWidget {
  const CharacterInfoWidget({
    super.key,
    required this.character,
  });

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 260,
              child: Image.network(
                character.image ?? '',
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, exception, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.error,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: 30,
              top: 55,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  height: 44,
                  width: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/arrow_left.svg',
                    height: 15,
                    width: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        CharacterInfoTile(
          title: LanguageUtils.name,
          subTitle: '${character.name}',
          imagePath: 'assets/information.svg',
        ),
        CharacterInfoTile(
          title: LanguageUtils.status,
          subTitle: '${character.status}',
          imagePath: 'assets/status/${character.status!.toLowerCase()}.svg',
        ),
        CharacterInfoTile(
          title: LanguageUtils.species,
          subTitle: '${character.species}',
          imagePath: 'assets/species/${character.species!.toLowerCase()}.svg',
        ),
        CharacterInfoTile(
          title: LanguageUtils.gender,
          subTitle: '${character.gender}',
          imagePath: 'assets/gender/${character.gender!.toLowerCase()}.svg',
        )
      ],
    );
  }
}

class CharacterInfoTile extends StatelessWidget {
  const CharacterInfoTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.imagePath,
  });

  final String subTitle;
  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.only(
        left: 20,
      ),
      minVerticalPadding: 0,
      leading: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFF11B0C8),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          colorFilter: ColorFilter.mode(
            Color(0xFFF8F8F8),
            BlendMode.srcIn,
          ),
          fit: BoxFit.fill,
          imagePath,
          height: 24,
          width: 24,
        ),
      ),
      title: Text(title),
      subtitle: Text(subTitle),
    );
  }
}
