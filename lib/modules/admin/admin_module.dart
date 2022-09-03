import 'package:bolao_palmeiras/modules/admin/controller/admin_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import '../../app/models/partida_model.dart';
import 'admin_page.dart';

class AdminModule extends Module {
  @override
  List<Bind<Object>> get binds =>
      [BlocBind.lazySingleton((i) => AdminController(adminService: i()))];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) {
          final PartidaModel? partida = args.data;
          return AdminPage(
            adminController: Modular.get(),
            valorAposta: partida?.valorAposta ?? 0,
          );
        })
      ];
}
