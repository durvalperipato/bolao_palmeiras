// ignore_for_file: public_member_api_docs, sort_constructors_first
class Partida {
  String mandante;
  String visitante;
  String data;
  String hora;
  String campeonato;
  int valorAposta;

  Partida({
    required this.mandante,
    required this.visitante,
    required this.data,
    required this.hora,
    required this.campeonato,
    required this.valorAposta,
  });
}
