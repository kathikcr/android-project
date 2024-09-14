import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataService {
  FirebaseAuth auth;

  FirebaseFirestore firestore;
  UserDataService({required this.auth, required this.firestore});
  addUserDataToFireStore() async {}
}
