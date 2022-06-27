import 'package:bolao_palmeiras/app/entities/aposta.dart';

class ApostaModel extends Aposta {
  ApostaModel(
      {required super.user,
      required super.placarMandante,
      required super.placarVisitante,
      required super.avatarURL});

  factory ApostaModel.fromEntity(Aposta aposta) {
    return ApostaModel(
        user: aposta.user,
        placarMandante: aposta.placarMandante,
        placarVisitante: aposta.placarVisitante,
        avatarURL: aposta.avatarURL);
  }

  factory ApostaModel.fromMap(Map<String, dynamic> map) {
    return ApostaModel(
        user: map['user'],
        placarMandante: map['mandante'],
        placarVisitante: map['visitante'],
        avatarURL: map['avatar_url']);
  }

  Map<String, dynamic> toMap() {
    return {
      "user": super.user,
      "mandante": super.placarMandante,
      "visitante": super.placarVisitante,
      "avatar_url": avatarURL
    };
  }
}
