// ignore_for_file: public_member_api_docs, sort_constructors_first
class Aposta {
  String user;
  String placarMandante;
  String placarVisitante;
  String? avatarURL;
  Aposta({
    required this.user,
    required this.placarMandante,
    required this.placarVisitante,
    required this.avatarURL,
  });

  @override
  String toString() {
    return 'Aposta(user: $user, placarMandante: $placarMandante, placarVisitante: $placarVisitante, avatarURL: $avatarURL)';
  }
}
