class StockLtp {
  final double regularMarketPrice;
  final double previoudClose;
  final double chartPreviousClose;

  StockLtp({
    required this.regularMarketPrice,
    required this.previoudClose,
    required this.chartPreviousClose,
  });

  factory StockLtp.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> meta = json["meta"] as Map<String, dynamic>;
    double regularMarketPrice =
            double.parse(meta["regularMarketPrice"].toString()),
        chartPreviousClose =
            double.parse(meta["chartPreviousClose"].toString()),
        previousClose = double.parse(meta["previousClose"].toString());

    // for (var entry in json.entries) {
    //   if (entry.key == "meta") {
    //     meta = entry.value as Map<String, dynamic>;
    //     meta.forEach((key, value) {
    //       if (key == "regularMarketPrice") {
    //         regularMarketPrice = double.parse(value.toString());
    //       } else if (key == "chartPreviousClose") {
    //         chartPreviousClose = double.parse(value.toString());
    //       } else if (key == "previousClose") {
    //         previousClose = double.parse(value.toString());
    //       }
    //     });
    //     break;
    //   }
    // }
    return StockLtp(
      regularMarketPrice: regularMarketPrice,
      chartPreviousClose: chartPreviousClose,
      previoudClose: previousClose,
    );
  }
}
