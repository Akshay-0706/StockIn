import 'dart:convert';

import 'package:http/http.dart' as http;

import 'chart.dart';
import 'finances.dart';
import 'indices.dart';

Future<Chart> fetchStock(String key, String range, String interval) async {
  final response =
      await http.get(Uri.parse("http://localhost/stock/$key/$range/$interval"));

  if (response.statusCode == 200) {
    return Chart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch stock");
  }
}

Future<Indices> fetchIndices(String type) async {
  final response = await http.get(Uri.parse(type == "nse"
      ? "http://localhost/indices"
      : "https://api.bseindia.com/BseIndiaAPI/api/IndexMovers/w"));

  if (response.statusCode == 200) {
    return Indices.fromJson(type, jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch stock");
  }
}

Future<Finances> fetchFinances() async {
  final response = await http.get(Uri.parse("http://localhost/finances"));

  if (response.statusCode == 200) {
    return Finances.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch finances");
  }
}
