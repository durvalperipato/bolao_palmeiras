import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Database {
  FirebaseFirestore? getInstance();
  Future<String> getUrlDownloadFromStorage({required String time});
}
