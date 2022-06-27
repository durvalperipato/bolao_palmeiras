import 'dart:convert';

import 'package:bolao_palmeiras/app/entities/campeonato.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CampeonatoModel {
  String nome;
  CampeonatoModel._({
    required this.nome,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
    };
  }

  factory CampeonatoModel.fromEntity(Campeonato campeonato) {
    return CampeonatoModel._(nome: campeonato.nome);
  }

  factory CampeonatoModel.fromMap(Map<String, dynamic> map) {
    return CampeonatoModel._(
      nome: map['nome'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CampeonatoModel.fromJson(String source) =>
      CampeonatoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
