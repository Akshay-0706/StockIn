import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stockin/args.dart';
import 'package:stockin/stock/components/body.dart';

import '../database/data/stocks.dart';

class Stock extends StatelessWidget {
  const Stock({Key? key, required this.code, required this.name})
      : super(key: key);
  final String code, name;

  @override
  Widget build(BuildContext context) {
    final StockArgs stockArgs;

    if (code.isEmpty && name.isEmpty) {
      int random = Random().nextInt(stocks.length - 1);
      stockArgs = StockArgs(stocks.elementAt(random).values.last,
          stocks.elementAt(random).values.first);
    } else {
      stockArgs = StockArgs(code, name);
    }

    return Scaffold(
      body: StockBody(
        code: stockArgs.code,
        name: stockArgs.name,
      ),
    );
  }
}
