import 'package:flutter/material.dart';
import 'package:stockin/database/server/stocks.dart';

class DataSource extends DataTableSource {
  DataSource({required this.context});

  final BuildContext context;
  late List<StockInvested> rows;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= rows.length) return null;
    final row = rows[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD.toString())),
      ],
    );
  }

  @override
  int get rowCount => rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class CircularStocks {
  final String stockName;
  final double investedAmt;

  CircularStocks({required this.stockName, required this.investedAmt});
}
