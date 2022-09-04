import 'package:bolao_palmeiras/app/entities/campeonato.dart';
import 'package:bolao_palmeiras/app/models/partida_model.dart';

import '../../app/entities/time.dart';

abstract class AdminRepository {
  Future<List<Time>> buscarTimes();
  Future<List<Campeonato>> buscarCampeonatos();
  Future<void> enviarDados({required PartidaModel partida});
  Future<void> eraseBets();
}
