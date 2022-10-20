import 'package:flutter/material.dart';

import '../database/data/stocks.dart';

class SearchStock extends StatefulWidget {
  const SearchStock({super.key});

  @override
  State<SearchStock> createState() => _SearchStockState();
}

class _SearchStockState extends State<SearchStock> {
  final TextEditingController textEditingController = TextEditingController();
  String searchText = "";

  List<Map<String, String>> filteredQueries = [];

  void searchNames() {
    setState(() {
      filteredQueries = queries;
    });
  }

  void searchStocks() {
    textEditingController.addListener(() {
      if (textEditingController.text.isEmpty) {
        setState(() {
          searchText = '';
          filteredQueries = queries;
        });
      } else {
        setState(() {
          searchText = textEditingController.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (searchText.isNotEmpty) {
    //   for (Map<String, String> query in queries) {
    //     if (query["code"]!.contains(query.values) || query["name"] == searchText) {}
    //   }
    // }
    return Text("Hello");
  }
}
