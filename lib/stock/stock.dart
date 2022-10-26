import 'package:flutter/material.dart';
import 'package:stockin/args.dart';
import 'package:stockin/stock/components/body.dart';

class Stock extends StatelessWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StockArgs stockArgs =
        ModalRoute.of(context)!.settings.arguments as StockArgs;

    return Scaffold(
      body: StockBody(
        code: stockArgs.code,
        name: stockArgs.name,
      ),
    );
  }
}
