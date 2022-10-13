import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.red,
        ),
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate);
  }
}
