import 'package:flutter/material.dart';
import 'package:stockin/database/server/stocks.dart';

class DataSource extends DataTableSource {
  DataSource({
    required this.context,
    required this.stocks,
  });

  final BuildContext context;
  final List<StockInvested> stocks;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= stocks.length) return null;
    final StockInvested stock = stocks[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(stock.symbol)),
        DataCell(Text(stock.qty.toString())),
        DataCell(Text(stock.buyAvg.toString())),
        DataCell(Text(stock.buyValue.toString())),
        DataCell(Text(stock.ltp.toString())),
        DataCell(Text(stock.presentValue.toString())),
        DataCell(Text(
          stock.pnl.toString(),
          style: TextStyle(
              color: stock.pnl >= 0 ? Colors.greenAccent : Colors.redAccent),
        )),
        DataCell(Text(
          "${stock.pnlChg}%",
          style: TextStyle(
              color: stock.pnlChg >= 0 ? Colors.greenAccent : Colors.redAccent),
        )),
      ],
    );
  }

  @override
  int get rowCount => stocks.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class CircularStocks {
  final String stockName;
  final double investedPartition;

  CircularStocks({required this.stockName, required this.investedPartition});
}
