class Stocks {
  final List<Map<String, dynamic>> stocks;

  Stocks(this.stocks);

  factory Stocks.fromJson(List<dynamic> json) {
    List<Map<String, dynamic>> stocks = [];

    for (var element in json) {
      stocks.add(element as Map<String, dynamic>);
    }

    return Stocks(stocks);
  }
}

class StockInvested {
  final String code;
  final double qty, buyAvg, buyValue, ltp, presentValue, pnl, pnlChg;

  StockInvested(this.code, this.qty, this.buyAvg, this.buyValue, this.ltp, this.presentValue, this.pnl, this.pnlChg);
  
}
