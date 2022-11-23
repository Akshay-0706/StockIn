class TopIndices {
  final List<Map<String, dynamic>> topIndices;

  TopIndices(this.topIndices);

  factory TopIndices.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> topIndices = [];
    topIndices.add(json["Sensex"]);
    topIndices.add(json["N50"]);
    topIndices.add(json["NIT"]);
    topIndices.add(json["NBank"]);
    topIndices.add(json["NFMCG"]);
    topIndices.add(json["NPharma"]);

    return TopIndices(topIndices);
  }
}
