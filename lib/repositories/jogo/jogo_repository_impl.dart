import 'dart:developer';

import 'package:bolao_palmeiras/app/entities/aposta.dart';
import 'package:bolao_palmeiras/core/constants/constants.dart';
import 'package:bolao_palmeiras/core/database/database.dart';
import 'package:bolao_palmeiras/repositories/jogo/jogo_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JogoRepositoryImpl implements JogoRepository {
  final Database _database;

  JogoRepositoryImpl({required Database database}) : _database = database;

  @override
  Future<Map<String, dynamic>> buscarPartida() async {
    var database = _database.getInstance();
    try {
      if (database != null) {
        var document =
            await database.collection(DatabaseNames.BOLAO).doc(DatabaseNames.PARTIDA).get();

        return document.data() as Map<String, dynamic>;
      } else {
        throw FirebaseException(plugin: 'Erro ao buscar partida');
      }
    } catch (e, s) {
      log('Erro ao buscar os dados da partida no banco de dados', error: e, stackTrace: s);
      throw Exception();
    }
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> snapshotPartida() {
    var database = _database.getInstance();
    if (database != null) {
      return database.collection(DatabaseNames.BOLAO).doc(DatabaseNames.PARTIDA).snapshots();
    } else {
      throw NullThrownError();
    }
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> snapshotApostas() {
    var database = _database.getInstance();
    if (database != null) {
      return database.collection(DatabaseNames.BOLAO).doc(DatabaseNames.APOSTAS).snapshots();
    } else {
      throw NullThrownError();
    }
  }

  @override
  Future<void> addBet(Aposta aposta) async {
    var database = _database.getInstance();
    try {
      if (database != null) {
        if (aposta.user == '') {
          aposta.user = 'ERRO FDP';
        }
        await database.collection(DatabaseNames.BOLAO).doc(DatabaseNames.APOSTAS).set({
          aposta.user: {
            "mandante": aposta.placarMandante,
            "visitante": aposta.placarVisitante,
            "avatar_url": aposta.avatarURL ?? '',
          }
        }, SetOptions(merge: true));
      }
    } catch (e) {
      throw FirebaseException(plugin: 'Erro ao realizar aposta para o usuário: ${aposta.user}');
    }
  }

  @override
  Future<List<Aposta>> buscarApostas() async {
    var database = _database.getInstance();
    List<Aposta> apostas = [];
    if (database != null) {
      var document =
          await database.collection(DatabaseNames.BOLAO).doc(DatabaseNames.APOSTAS).get();
      if (document.data() != null) {
        Map<String, dynamic>? response = document.data();
        if (response != null) {
          for (var aposta in response.entries) {
            final user = aposta.key;
            final placarMandante = aposta.value['mandante'];
            final placarVisitante = aposta.value['visitante'];
            final avatarURL = aposta.value['avatar_url'] ?? '';
            apostas.add(
              Aposta(
                user: user,
                placarMandante: placarMandante,
                placarVisitante: placarVisitante,
                avatarURL: avatarURL,
              ),
            );
          }
        }
      }
    }

    return apostas;
  }

  @override
  Future<String> buscarEscudo({required String time}) async {
    return await _database.getUrlDownloadFromStorage(time: time);
  }
}
