import 'dart:convert';

import 'package:stockin/database/stock/chart.dart';
import 'package:http/http.dart' as http;

Future<Chart> fetchStock(String key, String range, String interval) async {
  final response =
      await http.get(Uri.parse("http://localhost/stock/$key/$range/$interval"));

  if (response.statusCode == 200) {
    return Chart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch stock");
  }
}
