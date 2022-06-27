import 'package:bolao_palmeiras/modules/login/controller/login_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'login_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    BlocBind.lazySingleton((i) => LoginController(authService: i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (context, args) => LoginPage(
              controller: Modular.get(),
            )),
  ];
}
