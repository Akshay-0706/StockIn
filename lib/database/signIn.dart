import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

import '../global.dart';

class SignInProvider {
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

    final response = await http
        .post(Uri.parse(
            "${GlobalParams.server}/firebase/${userCredentials.user!.email!.replaceAll(".", "_")}"))
        .catchError((error) {
      return Response("Account already exists, loggin in", 409);
    });

    if (response.statusCode == 409) {
      print(response.body);
    } else {
      print("An unknown error occured: ");
    }

    return userCredentials.user;
  }

  static Future<void> googleLogout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<bool> googleDelete(String email) async {
    final response = await http.delete(Uri.parse(
        "https://8a2e-43-250-209-165.in.ngrok.io/firebase/akshay0706vhatkar@gmail_com"));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
