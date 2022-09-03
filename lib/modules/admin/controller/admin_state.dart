// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'admin_controller.dart';

enum AdminStatus { initial, loading, success, failure }

class AdminState extends Equatable {
  final AdminStatus status;
  final int betValue;
  final List<TimeModel> times;
  final List<CampeonatoModel> campeonatos;

  const AdminState._({
    required this.status,
    required this.times,
    required this.campeonatos,
    required this.betValue,
  });

  factory AdminState.initial() =>
      const AdminState._(status: AdminStatus.initial, times: [], campeonatos: [], betValue: 0);

  AdminState copyWith(
          {AdminStatus? status,
          List<TimeModel>? times,
          List<CampeonatoModel>? campeonatos,
          int? betValue}) =>
      AdminState._(
        status: status ?? this.status,
        times: times ?? this.times,
        campeonatos: campeonatos ?? this.campeonatos,
        betValue: betValue ?? this.betValue,
      );

  @override
  List<Object?> get props => [status, times, campeonatos, betValue];
}
