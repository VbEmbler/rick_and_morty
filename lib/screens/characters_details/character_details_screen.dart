import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/language_utils.dart';
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/res/project_colors.dart';
import 'package:rick_and_morty/res/project_icons.dart';
import 'package:rick_and_morty/res/project_text_styles.dart';
import 'package:rick_and_morty/screens/characters_details/character_details_bloc.dart';
import 'package:rick_and_morty/screens/characters_details/character_details_state.dart';
import 'package:rick_and_morty/utils/screen_init_status.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CharacterDetailsBloc, CharacterDetailsState>(
        builder: (context, state) {
          if (state.screenInitStatus == ScreenInitStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.screenInitStatus == ScreenInitStatus.success) {
            CharacterModel character = state.character!;
            return CharacterInfoWidget(character: character);
          }
          return Placeholder();
        },
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
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
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
                    color: ProjectColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    ProjectIcons.arrowLeft,
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      ProjectColors.nero,
                      BlendMode.srcIn,
                    ),
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
          imagePath: ProjectIcons.information,
        ),
        CharacterInfoTile(
          title: LanguageUtils.status,
          subTitle: '${character.status?.statusUpperCase}',
          imagePath: '${character.status?.statusIcon}',
        ),
        CharacterInfoTile(
          title: LanguageUtils.species,
          subTitle: '${character.species?.speciesUpperCase}',
          imagePath: '${character.species?.speciesIcon}',
        ),
        CharacterInfoTile(
          title: LanguageUtils.gender,
          subTitle: '${character.gender?.genderUpperCase}',
          imagePath: '${character.gender?.genderIcon}',
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
          color: ProjectColors.irisBlue,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          colorFilter: ColorFilter.mode(
            ProjectColors.whiteSmoke,
            BlendMode.srcIn,
          ),
          fit: BoxFit.fill,
          imagePath,
          height: 24,
          width: 24,
        ),
      ),
      title: Text(
        title,
        style: ProjectTextStyles.bodyMedium.copyWith(color: ProjectColors.grey),
      ),
      subtitle: Text(
        subTitle,
        style: ProjectTextStyles.subtitleBold.copyWith(
          color: ProjectColors.nero,
        ),
      ),
    );
  }
}
