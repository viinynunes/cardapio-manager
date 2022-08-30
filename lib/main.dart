import 'package:cardapio_manager/main_app.dart';
import 'package:cardapio_manager/src/modules/binds_and_routes/main_module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ModularApp(module: MainModule(), child: const MainApp()));
}
