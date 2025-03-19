import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
