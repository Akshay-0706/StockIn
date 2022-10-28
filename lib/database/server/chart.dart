class Chart {
  static List<String> interval = [
    "1m",
    "2m",
    "5m",
    "15m",
    "30m",
    "60m",
    "90m",
    "1h",
    "1d",
    "5d",
    "1wk",
    "1mo",
    "3mo"
  ];
  final double regularMarketPrice;
  final double chartPreviousClose;
  final double previousClose;
  final List<dynamic> validRanges;
  final List<dynamic> timestamp;
  final List<dynamic> open;
  final List<dynamic> close;
  final List<dynamic> low;
  final List<dynamic> high;
  final List<dynamic> volume;

  Chart(
      {required this.regularMarketPrice,
      required this.chartPreviousClose,
      required this.previousClose,
      required this.validRanges,
      required this.timestamp,
      required this.open,
      required this.close,
      required this.low,
      required this.high,
      required this.volume});

  factory Chart.fromJson(Map<String, dynamic> json) {
    late double regularMarketPrice, chartPreviousClose, previousClose;
    late Map<String, dynamic> meta;
    late List<dynamic> timestamp, open, close, low, high, volume;
    late List<dynamic> validRanges;

    for (var entry in json.entries) {
      if (entry.key == "meta") {
        meta = entry.value as Map<String, dynamic>;
        meta.forEach((key, value) {
          if (key == "regularMarketPrice") {
            regularMarketPrice = double.parse(value.toString());
          } else if (key == "chartPreviousClose") {
            chartPreviousClose = double.parse(value.toString());
          } else if (key == "previousClose") {
            previousClose = double.parse(value.toString());
          } else if (key == "validRanges") {
            validRanges = value as List<dynamic>;
          }
        });
      }

      if (entry.key == "timestamp") {
        timestamp = entry.value as List<dynamic>;
      }

      if (entry.key == "indicators") {
        Map<String, dynamic> indicators = entry.value as Map<String, dynamic>;
        List<dynamic> list = indicators["quote"];
        // for (var element in indicators.entries) {
        //   if (element.key == "quote") {
        //     list = indicators.entries as List<dynamic>;
        //   }
        // }

        Map<String, dynamic> quote = list[0];

        quote.forEach((key, value) {
          if (key == "open") {
            open = value as List<dynamic>;
          }
          if (key == "close") {
            close = value as List<dynamic>;
          }
          if (key == "low") {
            low = value as List<dynamic>;
          }
          if (key == "high") {
            high = value as List<dynamic>;
          }
          if (key == "volume") {
            volume = value as List<dynamic>;
          }
        });
      }
    }
    // print(validRanges);
    // print(regularMarketPrice);
    // print(chartPreviousClose);
    // print(previousClose);
    // print(timestamp);
    // print(open);
    // print(close);
    // print(low);
    // print(high);
    // print(volume);
    return Chart(
      regularMarketPrice: regularMarketPrice,
      chartPreviousClose: chartPreviousClose,
      previousClose: previousClose,
      validRanges: validRanges,
      timestamp: timestamp,
      open: open,
      close: close,
      low: low,
      high: high,
      volume: volume,
    );
  }
}
