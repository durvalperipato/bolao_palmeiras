import 'dart:convert';

import '../entities/time.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TimeModel {
  String nome;

  TimeModel._({
    required this.nome,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
    };
  }

  factory TimeModel.fromEntity(Time time) {
    return TimeModel._(nome: time.nome);
  }

  factory TimeModel.fromMap(Map<String, dynamic> map) {
    return TimeModel._(
      nome: map['nome'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeModel.fromJson(String source) =>
      TimeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
