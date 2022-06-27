import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app/entities/aposta.dart';

abstract class JogoRepository {
  Future<Map<String, dynamic>> buscarPartida();
  Stream<DocumentSnapshot<Map<String, dynamic>>> snapshotPartida();
  Stream<DocumentSnapshot<Map<String, dynamic>>> snapshotApostas();
  Future<void> addBet(Aposta aposta);
  Future<List<Aposta>> buscarApostas();
  Future<String> buscarEscudo({required String time});
}
