import 'package:bolao_palmeiras/core/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Firebase implements Database {
  @override
  FirebaseFirestore? getInstance() {
    return FirebaseFirestore.instance;
  }

  @override
  Future<String> getUrlDownloadFromStorage({required String time}) async {
    var storageRef = FirebaseStorage.instance.ref();
    return await storageRef.child("escudos/$time.png").getDownloadURL();
  }
}
