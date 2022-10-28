import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stockin/global.dart';

import 'chart.dart';
import 'stocks.dart';
import 'indices.dart';

Future<Chart> fetchStock(String code, String range, String interval) async {
  final response = await http
      .get(Uri.parse("${GlobalParams.ngrok}/stock/$code/$range/$interval"));

  if (response.statusCode == 200) {
    return Chart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch chart");
  }
}

Future<Indices> fetchIndices(String type) async {
  final response = await http.get(Uri.parse(type == "nse"
      ? "${GlobalParams.ngrok}/indices"
      : "https://api.bseindia.com/BseIndiaAPI/api/IndexMovers/w"));

  if (response.statusCode == 200) {
    return Indices.fromJson(type, jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch indices");
  }
}

Future<Stocks> fetchFinances() async {
  final response =
      await http.get(Uri.parse("${GlobalParams.ngrok}/firebase/stocks"));

  if (response.statusCode == 200) {
    return Stocks.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch stocks");
  }
}
