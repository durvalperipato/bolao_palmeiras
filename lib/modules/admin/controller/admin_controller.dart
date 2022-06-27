import 'package:bolao_palmeiras/app/models/partida_model.dart';
import 'package:bolao_palmeiras/services/admin/admin_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/models/campeonato_model.dart';
import '../../../app/models/time_model.dart';

part 'admin_state.dart';

class AdminController extends Cubit<AdminState> {
  final AdminService _adminService;

  AdminController({required AdminService adminService})
      : _adminService = adminService,
        super(AdminState.initial());

  Future<void> buscarDados() async {
    emit(state.copyWith(status: AdminStatus.loading));
    try {
      var campeonatos = await _adminService.buscarCampeonatos();
      campeonatos.sort(
        (a, b) => a.nome.compareTo(b.nome),
      );
      var times = await _adminService.buscarTimes();
      times.sort(
        (a, b) => a.nome.compareTo(b.nome),
      );
      emit(state.copyWith(
          status: AdminStatus.success, campeonatos: campeonatos, times: times));
    } catch (e) {
      emit(state
          .copyWith(status: AdminStatus.failure, campeonatos: [], times: []));
    }
  }

  Future<void> enviarDados(
      {required String mandante,
      required String visitante,
      required String campeonato,
      required String hora,
      required String data,
      required int valorAposta}) async {
    try {
      var partida = PartidaModel(
          mandante: mandante,
          visitante: visitante,
          data: data,
          hora: hora,
          campeonato: campeonato,
          valorAposta: valorAposta);

      _adminService.enviarDados(partida: partida);
      emit(state.copyWith(status: AdminStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AdminStatus.failure));
    }
  }
}
