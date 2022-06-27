import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app/models/aposta_model.dart';
import '../../app/models/partida_model.dart';

abstract class JogoService {
  Future<PartidaModel> buscarJogo();
  Stream<DocumentSnapshot<Map<String, dynamic>>> snapshotPartida();
  Stream<DocumentSnapshot<Map<String, dynamic>>> snapshotApostas();
  PartidaModel update(Map<String, dynamic> partidaMap);
  Future<void> addBet({required ApostaModel apostaModel});
  Future<List<ApostaModel>> buscarApostas();
  Future<String> buscarEscudo({required String time});
}
