import 'package:bolao_palmeiras/app/entities/campeonato.dart';
import 'package:bolao_palmeiras/core/constants/constants.dart';
import 'package:bolao_palmeiras/core/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app/entities/time.dart';
import '../../app/models/partida_model.dart';
import 'admin_repository.dart';

class AdminRepositoryImpl implements AdminRepository {
  final Database _database;

  AdminRepositoryImpl({required Database database}) : _database = database;

  @override
  Future<List<Campeonato>> buscarCampeonatos() async {
    var database = _database.getInstance();

    try {
      if (database != null) {
        var dados = await database.collection(DatabaseNames.BOLAO).doc(DatabaseNames.DADOS).get();
        var campeonatos = dados.data()!['campeonatos'] as List<dynamic>;
        return campeonatos.map<Campeonato>((nome) => Campeonato(nome: nome)).toList();
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Time>> buscarTimes() async {
    var database = _database.getInstance();

    try {
      if (database != null) {
        var dados = await database.collection(DatabaseNames.BOLAO).doc(DatabaseNames.DADOS).get();
        var times = dados.data()!['times'] as List<dynamic>;
        return times.map<Time>((nome) => Time(nome: nome)).toList();
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> enviarDados({required PartidaModel partida}) async {
    var database = _database.getInstance();

    try {
      if (database != null) {
        var document = database.collection(DatabaseNames.BOLAO).doc(DatabaseNames.PARTIDA);
        document.set(
          partida.toMap(),
          SetOptions(merge: true),
        );
      }
    } catch (e) {
      throw Exception();
    }
  }
}
