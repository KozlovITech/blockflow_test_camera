import 'package:flutter/material.dart';

import 'const/app_color.dart';

class AppTheme {
  static final ThemeData defaultTheme = _buildLightTheme();

  static ThemeData _buildLightTheme() {
    final ThemeData base = ThemeData.dark();

    return base.copyWith(
      primaryColor: AppColors.darkBG,
      primaryColorLight: AppColors.darkBG,
      colorScheme: const ColorScheme.dark().copyWith(
        secondary: AppColors.darkBG,
        error: AppColors.red,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBG,
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
        centerTitle: false,
        elevation: 0,
        // systemOverlayStyle: // This setup in main by SystemChrome (setup using AppBarTheme doesn't always work)
        titleTextStyle: TextStyle(color: AppColors.darkBG),
      ),
      scaffoldBackgroundColor: AppColors.darkBG,
      cardColor: AppColors.darkBG,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.darkBG),
      ),
    );
  }
}
