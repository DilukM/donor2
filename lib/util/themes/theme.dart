import 'package:donor2/util/colors/colors.dart';

import 'package:donor2/util/themes/custom_themes/appbar_theme.dart';
import 'package:donor2/util/themes/custom_themes/bottom_sheet_themes.dart';
import 'package:donor2/util/themes/custom_themes/elevated_button_theme.dart';
import 'package:donor2/util/themes/custom_themes/text_field_theme.dart';
import 'package:donor2/util/themes/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const colors = AppColors();
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.colors.primary),
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.lightTextTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
    bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
    appBarTheme: AppBar_Theme.lightAppBarTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    colorScheme:
        ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 216, 64, 53)),
    scaffoldBackgroundColor: Colors.grey[900],
    textTheme: AppTextTheme.darkTextTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
    bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
    appBarTheme: AppBar_Theme.darkAppBarTheme,
  );
}
