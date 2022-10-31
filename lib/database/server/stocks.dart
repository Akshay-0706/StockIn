class Stocks {
  final List<StockInvested> investedStocks;

  Stocks(this.investedStocks);

  factory Stocks.fromJson(Map<String, dynamic> json) {
    List<StockInvested> investedStocks = [];
    late double byPrice, qty;

    json.forEach((key, value) {
      Map<String, dynamic> entry = value as Map<String, dynamic>;
      entry.forEach((key, value) {
        if (key == "byPrice") {
          byPrice = double.parse(value.toString());
        } else {
          qty = double.parse(value.toString());
        }
      });
      investedStocks.add(
          StockInvested(key, qty, byPrice, qty * byPrice, 0, 0, 0, 0, 0, 0));
    });

    return Stocks(investedStocks);
  }
}

class StockInvested {
  final String symbol;
  final double qty, buyAvg, buyValue;
  double ltp, prevClose, presentValue, pnl, pnlChg, todaysPnl;

  StockInvested(this.symbol, this.qty, this.buyAvg, this.buyValue, this.ltp,
      this.prevClose, this.presentValue, this.pnl, this.pnlChg, this.todaysPnl);
}
