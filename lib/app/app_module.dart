import 'package:bolao_palmeiras/core/database/database.dart';
import 'package:bolao_palmeiras/core/database/firebase.dart';
import 'package:bolao_palmeiras/modules/login/login_module.dart';
import 'package:bolao_palmeiras/modules/splash/splash_page.dart';
import 'package:bolao_palmeiras/repositories/admin/admin_repository.dart';
import 'package:bolao_palmeiras/repositories/admin/admin_repository_impl.dart';
import 'package:bolao_palmeiras/repositories/jogo/jogo_repository.dart';
import 'package:bolao_palmeiras/repositories/jogo/jogo_repository_impl.dart';
import 'package:bolao_palmeiras/services/admin/admin_service.dart';
import 'package:bolao_palmeiras/services/admin/admin_service_impl.dart';
import 'package:bolao_palmeiras/services/auth/auth_service.dart';
import 'package:bolao_palmeiras/services/auth/google_auth.dart';
import 'package:bolao_palmeiras/services/jogo/jogo_service.dart';
import 'package:bolao_palmeiras/services/jogo/jogo_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../modules/admin/admin_module.dart';
import '../modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<AuthService>((i) => GoogleAuth()),
    Bind.lazySingleton<Database>((i) => Firebase()),
    Bind.lazySingleton<JogoRepository>(
        (i) => JogoRepositoryImpl(database: i())),
    Bind.lazySingleton<JogoService>(
        (i) => JogoServiceImpl(jogoRepository: i())),
    Bind.lazySingleton<AdminRepository>(
        (i) => AdminRepositoryImpl(database: i())),
    Bind.lazySingleton<AdminService>(
        (i) => AdminServiceImpl(adminRepository: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const SplashPage(),
    ),
    ModuleRoute('/login/', module: LoginModule()),
    ModuleRoute('/home/', module: HomeModule()),
    ModuleRoute('/admin/', module: AdminModule()),
  ];
}
