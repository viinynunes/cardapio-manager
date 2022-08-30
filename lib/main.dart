import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


}
