import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';

class JWT {
  static Future<String> signTheToken(User user) async {
    final response = (await http.get(Uri.parse(
        "${GlobalParams.server}/jwt/sign/${user.uid}/${user.email!.replaceAll(".", "_")}")));

    print("Token generated: " + response.body.toString());

    return response.body.toString();
  }

  static Future<bool> isTokenValid(String token) async {
    final response = (await http.get(
      Uri.parse("${GlobalParams.server}/jwt/verify"),
      headers: {
        "token": token,
      },
    ).catchError((error) => print(error)));
    return response.body.toString() == "Alive";
  }
}
