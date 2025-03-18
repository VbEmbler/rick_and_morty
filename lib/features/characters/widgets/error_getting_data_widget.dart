import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/language_utils.dart';

class ErrorGettingDataWidget extends StatelessWidget {
  const ErrorGettingDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      LanguageUtils.errorGettingData,
      style: const TextStyle(fontSize: 30.0, color: Colors.black),
    ));
  }
}
