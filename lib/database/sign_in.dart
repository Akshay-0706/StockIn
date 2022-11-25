import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';

class Auth {
  static Future<User?> googleLogin() async {
    final googleSignIn = GoogleSignIn();

    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredentials =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredentials.user;
  }

  static Future<void> googleLogout() async {
    await SharedPreferences.getInstance()
        .then((value) => value.remove("email"));
    await GoogleSignIn().signOut();
    await GoogleSignIn().disconnect();
    await FirebaseAuth.instance.signOut();
  }

  static Future<bool> googleDelete(String email) async {
    googleLogout();
    final response = await http.delete(Uri.parse(
        "${GlobalParams.server}/firebase/${email.replaceAll(".", "_")}"));

    return response.statusCode == 200;
  }
}
