import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PartidaModel {
  String mandante;
  String visitante;
  String data;
  String hora;
  String campeonato;
  int valorAposta;
  String? imageUrlMandante;
  String? imageUrlVisitante;

  PartidaModel({
    required this.mandante,
    required this.visitante,
    required this.data,
    required this.hora,
    required this.campeonato,
    required this.valorAposta,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mandante': mandante,
      'visitante': visitante,
      'data': data,
      'hora': hora,
      'campeonato': campeonato,
      'valor_aposta': valorAposta.toString(),
    };
  }

  factory PartidaModel.fromMap(Map<String, dynamic> map) {
    return PartidaModel(
      mandante: map['mandante'] as String,
      visitante: map['visitante'] as String,
      data: map['data'] as String,
      hora: map['hora'] as String,
      campeonato: map['campeonato'] as String,
      valorAposta: int.parse(map['valor_aposta']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PartidaModel.fromJson(String source) =>
      PartidaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PartidaModel(mandante: $mandante, visitante: $visitante, data: $data, hora: $hora, campeonato: $campeonato, valorAposta: $valorAposta, imageUrlMandante: $imageUrlMandante, imageUrlVisitante: $imageUrlVisitante)';
  }
}
