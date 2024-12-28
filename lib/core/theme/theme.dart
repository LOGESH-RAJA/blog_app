import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemMode = ThemeData.dark().copyWith(
      chipTheme: const ChipThemeData(
          side: BorderSide(style: BorderStyle.none),
          color: WidgetStatePropertyAll(AppPallete.backgroundColor)),
      appBarTheme:
          const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(10),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: AppPallete.gradient2)),
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 3, color: AppPallete.borderColor))));
}
