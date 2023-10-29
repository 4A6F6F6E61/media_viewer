import 'package:flutter/material.dart';

final lightMode = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: Colors.red,
    secondary: Colors.red,
  ),
);

final darkMode = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    primary: Colors.red,
    secondary: Colors.red,
  ),
);
