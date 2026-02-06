import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: .w700,
    ),
    backgroundColor: Color.fromARGB(255, 31, 31, 31),
  ),
  listTileTheme: ListTileThemeData(iconColor: Colors.white),
  dividerColor: Colors.white24,
  scaffoldBackgroundColor: Color.fromARGB(255, 31, 31, 31),
  colorScheme: .fromSeed(seedColor: Colors.yellow),
  textTheme: TextTheme(
    bodyLarge: const TextStyle(
      color: Colors.white,
      fontWeight: .w500,
      fontSize: 20,
    ),
    labelMedium:  TextStyle(
      color: Colors.white,
      fontWeight: .w700,
      fontSize: 18,
    ),
    bodyMedium: TextStyle(
      color: Colors.white.withValues(alpha: 0.6),
      fontWeight: .w700,
      fontSize: 14,
    ),
  ),
);
