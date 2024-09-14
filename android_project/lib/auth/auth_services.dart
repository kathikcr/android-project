import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider(
  (ref) => AuthServices(
    auth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(),
  ),
);

class AuthServices {
  GoogleSignIn googleSignIn;
  FirebaseAuth auth;
  AuthServices({required this.auth, required this.googleSignIn});
  signInWithGoogle() async {
    final user = await googleSignIn.signIn();
    final googleAuth = await user!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await auth.signInWithCredential(credential);
  }
}
