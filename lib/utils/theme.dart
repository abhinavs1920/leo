import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

final lightThemeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  textTheme: GoogleFonts.montserratTextTheme(ThemeData.light().textTheme),
  elevatedButtonTheme: elevatedButtonThemeData,
  outlinedButtonTheme: outlineButtonThemeData,
  inputDecorationTheme: inputDecorationThemeDataLight,
  iconTheme: iconThemeDataLight,
  primaryIconTheme: iconThemeDataLight,
);

final inputDecorationThemeDataLight = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: primaryColor,
      width: 2,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: primaryColor,
      width: 2,
    ),
  ),
  labelStyle: const TextStyle(
    color: primaryColor,
  ),
);

final elevatedButtonThemeData = ElevatedButtonThemeData(
  style: TextButton.styleFrom(
    backgroundColor: primaryColor,
    elevation: 0,
    padding: const EdgeInsets.all(defaultPadding),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(defaultBorderRadius),
      ),
    ),
  ),
);

final outlineButtonThemeData = OutlinedButtonThemeData(
  style: TextButton.styleFrom(
    backgroundColor: Colors.white,
    padding: const EdgeInsets.all(defaultPadding),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(defaultBorderRadius),
      ),
    ),
  ),
);

const iconThemeDataLight = IconThemeData(
  color: primaryColor,
);
