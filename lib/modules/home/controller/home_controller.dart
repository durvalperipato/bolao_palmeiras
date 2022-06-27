// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bolao_palmeiras/app/models/aposta_model.dart';
import 'package:bolao_palmeiras/app/models/partida_model.dart';
import 'package:bolao_palmeiras/services/auth/auth_service.dart';
import 'package:bolao_palmeiras/services/jogo/jogo_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/time_zone/time_zone.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final JogoService _jogoService;
  final AuthService _authService;
  late String userName;
  late String? avatar;

  HomeController({
    required AuthService authService,
    required JogoService jogoService,
  })  : _jogoService = jogoService,
        _authService = authService,
        super(HomeState.initial());

  void setUser({required String user, String? photoURL}) {
    userName = user;
    avatar = photoURL ?? '';
  }

  /*  Future<void> buscarPartida() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      var partida = await _jogoService.buscarJogo();
      
      emit(state.copyWith(partida: partida));
    } catch (e, s) {
      log('Erro ao buscar partida', error: e, stackTrace: s);
      emit(state.copyWith(
          status: HomeStatus.failure, message: 'Erro ao buscar partida'));
    }
  } */

  void listenPartida() {
    try {
      var snapshot = _jogoService.snapshotPartida();
      snapshot.listen((partidaMap) async {
        if (partidaMap.data() != null) {
          var partida = _jogoService.update(partidaMap.data()!);
          partida.imageUrlMandante =
              await _buscarEscudoDoTime(time: partida.mandante.toLowerCase());
          partida.imageUrlVisitante =
              await _buscarEscudoDoTime(time: partida.visitante.toLowerCase());

          emit(state.copyWith(partida: partida));
        }
      });
    } catch (e, s) {
      log('Erro ao atualizar partida em tempo real', error: e, stackTrace: s);
      emit(state.copyWith(
          status: HomeStatus.failure,
          message: 'Erro ao atualizar partida em tempo real'));
    }
  }

  void listenApostas() {
    try {
      var snapshot = _jogoService.snapshotApostas();
      snapshot.listen((apostasMap) async {
        if (apostasMap.data() != null) {
          var apostas = await _jogoService.buscarApostas();

          emit(state.copyWith(apostas: apostas));
        }
      });
    } catch (e, s) {
      log('Erro ao atualizar partida em tempo real', error: e, stackTrace: s);
      emit(state.copyWith(
          status: HomeStatus.failure,
          message: 'Erro ao atualizar partida em tempo real'));
    }
  }

  Future<void> buscarApostas() async {
    try {
      var apostas = await _jogoService.buscarApostas();
      apostas.sort(
        (name1, name2) => name1.user.compareTo(name2.user),
      );
      emit(state.copyWith(apostas: apostas));
    } catch (e) {
      emit(state.copyWith(
          status: HomeStatus.failure,
          message: 'Erro ao atualizar lista de apostas'));
    }
  }

  Future<void> bet(
      {required String user,
      required String placarMandante,
      required String placarVisitante,
      required String avatarUrl}) async {
    try {
      final aposta = ApostaModel(
          user: user,
          placarMandante: placarMandante,
          placarVisitante: placarVisitante,
          avatarURL: avatarUrl);

      var apostas = await _jogoService.buscarApostas();
      var partida = await _jogoService.buscarJogo();

      if (_verificarAposta(aposta: aposta, apostasRealizadas: apostas) &&
          _verificarHoraDaAposta(partida: partida)) {
        await _jogoService.addBet(apostaModel: aposta);

        emit(state.copyWith(
            status: HomeStatus.success, message: 'Placar enviado com sucesso'));
      } else {
        emit(state.copyWith(
            status: HomeStatus.failure,
            message: 'Aposta igual e/ou fora do horário'));
      }
    } catch (e, s) {
      log('Erro ao enviar aposta', error: e, stackTrace: s);
      emit(state.copyWith(
          status: HomeStatus.failure,
          message: 'Erro ao enviar aposta\n$e\n$s'));
    }
  }

  bool _verificarAposta(
      {required ApostaModel aposta,
      required List<ApostaModel> apostasRealizadas}) {
    var confirmado = true;

    for (var apostaAnterior in apostasRealizadas) {
      if (apostaAnterior.user != aposta.user) {
        if ((apostaAnterior.placarMandante == aposta.placarMandante &&
            apostaAnterior.placarVisitante == aposta.placarVisitante)) {
          confirmado = false;
        }
      }
    }

    return confirmado;
  }

  bool _verificarHoraDaAposta({required PartidaModel partida}) {
    var confirmado = true;
    var data = partida.data.split('/');
    var dia = int.parse(data.first);
    var mes = int.parse(data[1]);
    var ano = int.parse(data[2]);

    var time = partida.hora.split(':');
    var hora = int.parse(time[0]);
    var minuto = int.parse(time[1]);

    var horaAgora = TimeZone.setTimeZone();

    var date = DateTime(ano, mes, dia, hora, minuto);

    if (DateTime.now().day != dia) {
      confirmado = false;
    } else if (date.millisecondsSinceEpoch <= horaAgora) {
      confirmado = false;
    }
    return confirmado;
  }

  Future<String?> _buscarEscudoDoTime({required String time}) async {
    try {
      return await _jogoService.buscarEscudo(time: time);
    } catch (e) {
      emit(state.copyWith(
          status: HomeStatus.failure,
          message: 'Erro ao buscar escudo do time $time'));
      return null;
    }
  }

  Future<void> signOut() async {
    _authService.signOut();
  }
}
