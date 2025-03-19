import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/core/utils/language_utils.dart';
import 'package:rick_and_morty/features/characters/models/character_model.dart';
import 'package:rick_and_morty/features/characters/widgets/character_info_tile.dart';

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
                  return Placeholder();
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
