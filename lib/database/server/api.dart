import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stockin/database/server/regular_stock.dart';
import 'package:stockin/global.dart';

import 'chart.dart';
import 'stocks.dart';
import 'indices.dart';

Future<Chart> fetchChart(String code, String range, String interval) async {
  final response = await http
      .get(Uri.parse("${GlobalParams.server}/stock/$code/$range/$interval"));

  if (response.statusCode == 200) {
    return Chart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch chart");
  }
}

Future<Indices> fetchIndices(String type) async {
  final response = await http.get(Uri.parse(type == "nse"
      ? "${GlobalParams.server}/indices"
      : "https://api.bseindia.com/BseIndiaAPI/api/IndexMovers/w"));

  if (response.statusCode == 200) {
    return Indices.fromJson(type, jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch indices");
  }
}

Future<Stocks> fetchStocks(String email) async {
  final response = await http
      .get(Uri.parse("${GlobalParams.server}/firebase/stocks/$email"));

  if (response.statusCode == 200) {
    return Stocks.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch stocks");
  }
}

Future<StockLtp> fetchLtp(String code) async {
  final response =
      await http.get(Uri.parse("${GlobalParams.server}/stock/$code/1d/1m"));

  if (response.statusCode == 200) {
    return StockLtp.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch ltp");
  }
}

Future<void> putStock(
    String email, String mode, String code, String price, String qty) async {
  print("Inside function");
  final response = await http.put(Uri.parse(
      "${GlobalParams.server}/firebase/$email/$mode/$code/$price/$qty"));

  if (response.statusCode == 202) {
    return;
  } else {
    throw Exception("Failed to putting stock");
  }
}
