import '../../app/models/campeonato_model.dart';
import '../../app/models/partida_model.dart';
import '../../app/models/time_model.dart';

abstract class AdminService {
  Future<List<TimeModel>> buscarTimes();
  Future<List<CampeonatoModel>> buscarCampeonatos();
  Future<void> enviarDados({required PartidaModel partida, bool eraseBets = false});
}
