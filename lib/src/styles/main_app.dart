import 'package:cardapio_manager/src/styles/color_scheme.dart';
import 'package:cardapio_manager/src/styles/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: colorSchemeLight,
          textTheme: const TextTheme(
            titleMedium: titleMediumLight,
            labelMedium: labelMediumLight,
            bodyMedium: bodyMediumLight
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: colorSchemeDark,
          textTheme: const TextTheme(
            titleMedium: titleMediumDark,
            labelMedium: labelMediumDark,
            bodyMedium: bodyMediumDark,
          ),
        ),
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate);
  }
}
