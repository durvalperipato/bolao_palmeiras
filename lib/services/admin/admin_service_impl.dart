import 'package:bolao_palmeiras/app/models/campeonato_model.dart';
import 'package:bolao_palmeiras/app/models/partida_model.dart';
import 'package:bolao_palmeiras/app/models/time_model.dart';

import '../../repositories/admin/admin_repository.dart';
import 'admin_service.dart';

class AdminServiceImpl implements AdminService {
  final AdminRepository _adminRepository;

  AdminServiceImpl({required AdminRepository adminRepository}) : _adminRepository = adminRepository;

  @override
  Future<List<CampeonatoModel>> buscarCampeonatos() async {
    var nomes = <CampeonatoModel>[];
    var campeonatos = await _adminRepository.buscarCampeonatos();

    for (var campeonato in campeonatos) {
      nomes.add(CampeonatoModel.fromEntity(campeonato));
    }
    return nomes;
  }

  @override
  Future<List<TimeModel>> buscarTimes() async {
    var nomes = <TimeModel>[];
    var times = await _adminRepository.buscarTimes();

    for (var time in times) {
      nomes.add(TimeModel.fromEntity(time));
    }
    return nomes;
  }

  @override
  Future<void> enviarDados({required PartidaModel partida, bool eraseBets = false}) async {
    await _adminRepository.enviarDados(partida: partida);
    if (eraseBets) {
      await _adminRepository.eraseBets();
    }
  }
}
