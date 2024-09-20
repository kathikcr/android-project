import 'package:android_project/features/auth/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final UserDataServiceProvider = Provider(
  (ref) => UserDataService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class UserDataService {
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  UserDataService({required this.auth, required this.firestore});

  addUserDataToFireStore({
    required String displayName,
    required String username,
    required String email,
    required String description,
    required String profilePic,
  }) async {
    UserModel user = UserModel(
      displayName: displayName,
      username: username,
      email: email,
      profilePic: profilePic,
      subscription: [],
      videos: 0,
      userId: auth.currentUser!.uid,
      description: description,
      type: "user",
    );

    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .set(user.toMap());
  }
}
