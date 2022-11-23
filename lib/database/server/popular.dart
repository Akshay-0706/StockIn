class Popular {
  final List<PopularTrend> popular;

  Popular(this.popular);

  factory Popular.fromJson(Map<String, dynamic> json) {
    List<dynamic> data = json["Table"];
    Map<String, dynamic> indices;
    List<PopularTrend> popular = [];
    for (var element in data) {
      indices = element as Map<String, dynamic>;
      popular.add(PopularTrend(indices["LONG_NAME"], indices["scripname"],
          indices["trd_val"], indices["change_percent"]));
    }
    return Popular(popular);
  }
}

class PopularTrend {
  final String name, code;
  final double value, perChg;

  PopularTrend(this.name, this.code, this.value, this.perChg);
}
