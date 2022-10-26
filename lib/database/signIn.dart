import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInProvider {
  static Future<User?> googleLogin() async {
    final googleSignIn = GoogleSignIn();

    GoogleSignInAccount? googleSignInAccount;

    late User? user;
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return null;

    googleSignInAccount = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredentials =
        await FirebaseAuth.instance.signInWithCredential(credential);

    user = userCredentials.user;

    return userCredentials.user;
  }
}
