import 'package:bolao_palmeiras/app/app_module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_widget.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DefaultFirebaseOptions olhar documentação do package firebase_core (pub.dev)

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
