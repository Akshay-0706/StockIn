class Popular {
  final List<PopularTrend> popular;

  Popular(this.popular);

  factory Popular.fromJson(Map<String, dynamic> json) {
    List<dynamic> data = json["data"];
    Map<String, dynamic> indices;
    List<PopularTrend> popular = [];
    for (var element in data) {
      indices = element as Map<String, dynamic>;
      popular.add(PopularTrend(
          indices["symbol"],
          double.parse(indices["ltp"].toString().replaceAll(",", "")),
          double.parse(indices["netPrice"])));
    }
    return Popular(popular);
  }
}

class PopularTrend {
  final String code;
  final double value, perChg;

  PopularTrend(this.code, this.value, this.perChg);
}
