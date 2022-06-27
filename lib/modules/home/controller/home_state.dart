// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_controller.dart';

enum HomeStatus { initial, loading, sending, success, failure }

class HomeState extends Equatable {
  final List<ApostaModel>? apostas;
  final PartidaModel? partida;
  final HomeStatus? status;
  final String? message;
  const HomeState({
    this.apostas,
    required this.partida,
    required this.status,
    this.message,
  });

  const HomeState._(
      {this.status, required this.partida, this.message, this.apostas});

  HomeState.initial()
      : this._(
            status: HomeStatus.initial,
            partida: null,
            apostas: <ApostaModel>[]);

  HomeState copyWith(
          {HomeStatus? status,
          String? message,
          PartidaModel? partida,
          List<ApostaModel>? apostas}) =>
      HomeState._(
          status: status ?? this.status,
          message: message ?? this.message,
          partida: partida ?? this.partida,
          apostas: apostas ?? this.apostas);

  @override
  List<Object?> get props => [status, message, partida, apostas];
}
