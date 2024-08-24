import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';

class LoadingModal extends StatelessWidget {
  const LoadingModal({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width - 64,
        decoration: BoxDecoration(
          color: ThemeColors.getColorTheme(Config.themType)["color1"],
          borderRadius: BorderRadius.circular(12.8),
        ),
        alignment: Alignment.center,
        child: SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(
            color: ThemeColors.getColorTheme(Config.themType)["colorprimary"],
          ),
        ),
      ),
    );
  }
}
