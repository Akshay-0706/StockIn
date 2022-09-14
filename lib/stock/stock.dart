import 'package:flutter/material.dart';
import 'package:stockin/stock/components/body.dart';

class Stock extends StatelessWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StockBody(),
    );
  }
}
