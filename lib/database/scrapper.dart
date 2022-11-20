import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

import '../global.dart';

Future<String> getMarketMood() async {
  // print("Up");
  String marketMood = "";
  final response = await http.get(Uri.parse("${GlobalParams.server}/mmi"));
  // print("Down");

  // print(response.body);

  var document = parser.parse(response.body);
  marketMood = document.getElementsByClassName("mmi-value")[0].children[0].text;
  // print(marketMood);

  return marketMood;
}
