import 'package:flutter/material.dart';
import 'package:flutter_practical/core/constants/ui_constants.dart';

import 'color_palette.dart';

mixin AppTheme {
  ThemeData lightTheme() => ThemeData(
        fontFamily: 'Gilroy',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: ColorPalette.colorWhite,
          iconTheme: IconThemeData(
            color: ColorPalette.colorBlack,
          ),
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: ColorPalette.colorBlack,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(color: ColorPalette.colorBlack, fontSize: 12),
          bodyMedium: TextStyle(color: ColorPalette.colorBlack, fontSize: 14),
          bodyLarge: TextStyle(color: ColorPalette.colorBlack, fontSize: 16),
          headlineSmall:
              TextStyle(color: ColorPalette.colorBlack, fontSize: 18),
          headlineMedium:
              TextStyle(color: ColorPalette.colorBlack, fontSize: 20),
          displaySmall: TextStyle(color: ColorPalette.colorBlack, fontSize: 22),
          displayMedium:
              TextStyle(color: ColorPalette.colorBlack, fontSize: 24),
          displayLarge: TextStyle(color: ColorPalette.colorBlack, fontSize: 26),
        ),
        useMaterial3: false,
        colorScheme: const ColorScheme.light().copyWith(
          primary: ColorPalette.primaryColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(0),
            minimumSize: const MaterialStatePropertyAll<Size>(
              Size(double.infinity, 42),
            ),
            alignment: Alignment.center,
            textStyle: const MaterialStatePropertyAll(
              TextStyle(
                color: Colors.white,
                fontFamily: 'Gilroy',
                fontSize: 18,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all(ColorPalette.primaryColor),
            shape: const MaterialStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(defaultButtonRadius),
                ),
              ),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding: allPadding12,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorPalette.primaryColor),
            borderRadius: BorderRadius.circular(defaultButtonRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorPalette.primaryColor),
            borderRadius: BorderRadius.circular(defaultButtonRadius),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorPalette.primaryColor),
            borderRadius: BorderRadius.circular(defaultButtonRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorPalette.primaryColor),
            borderRadius: BorderRadius.circular(defaultButtonRadius),
          ),
          hintStyle: const TextStyle(
            color: ColorPalette.colorHintText,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            fontSize: 14,
          ),
        ),
      );

  ThemeData darkTheme() => ThemeData(colorScheme: const ColorScheme.dark());
}
