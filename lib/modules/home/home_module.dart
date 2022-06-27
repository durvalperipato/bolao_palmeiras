import 'package:bolao_palmeiras/modules/home/controller/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        BlocBind.lazySingleton(
            (i) => HomeController(jogoService: i(), authService: i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) {
          // Para rodar localhost no Flutter Web como a linha abaixo

          //final user = args.data?["name"] as String? ?? 'Durval';

          final user = args.data?["name"] as String? ?? 'Erro';
          final photoURL = args.data?["avatar"] as String?;

          return HomePage(
            controller: Modular.get()..setUser(user: user, photoURL: photoURL),
          );
        })
      ];
}
