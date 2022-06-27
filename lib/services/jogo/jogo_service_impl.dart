import 'package:bolao_palmeiras/app/models/aposta_model.dart';
import 'package:bolao_palmeiras/app/models/partida_model.dart';
import 'package:bolao_palmeiras/repositories/jogo/jogo_repository.dart';
import 'package:bolao_palmeiras/services/jogo/jogo_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app/entities/aposta.dart';

class JogoServiceImpl implements JogoService {
  final JogoRepository _jogoRepository;

  JogoServiceImpl({required JogoRepository jogoRepository})
      : _jogoRepository = jogoRepository;

  @override
  Future<PartidaModel> buscarJogo() async {
    var partidaMap = await _jogoRepository.buscarPartida();
    var partida = PartidaModel.fromMap(partidaMap);
    return partida;
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> snapshotPartida() {
    return _jogoRepository.snapshotPartida();
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> snapshotApostas() {
    return _jogoRepository.snapshotApostas();
  }

  @override
  PartidaModel update(Map<String, dynamic> partidaMap) {
    var partida = PartidaModel.fromMap(partidaMap);

    return partida;
  }

  @override
  Future<void> addBet({required ApostaModel apostaModel}) async {
    final aposta = Aposta(
        user: apostaModel.user,
        placarMandante: apostaModel.placarMandante,
        placarVisitante: apostaModel.placarVisitante,
        avatarURL: apostaModel.avatarURL);
    await _jogoRepository.addBet(aposta);
  }

  @override
  Future<List<ApostaModel>> buscarApostas() async {
    var apostas = await _jogoRepository.buscarApostas();
    return apostas
        .map<ApostaModel>((aposta) => ApostaModel.fromEntity(aposta))
        .toList();
  }

  @override
  Future<String> buscarEscudo({required String time}) async {
    return await _jogoRepository.buscarEscudo(time: time);
  }
}
