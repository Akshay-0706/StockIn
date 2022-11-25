import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';

class Auth {
  static Future<User?> googleLogin() async {
    final googleSignIn = GoogleSignIn();

    final googleUser = await googleSignIn.signIn().catchError((error) => null);

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
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("email");
    pref.setString("token", "Logged out");
    globalToken.setToken("Logged out");
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
