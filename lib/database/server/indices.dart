class Indices {
  final List<Index> indices;
  final String type;
  Indices(this.indices, this.type);

  factory Indices.fromJson(String type, Map<String, dynamic> json) {
    List<Index> indices = [];
    List<dynamic> data;
    Map<String, dynamic> ind;
    String compare = type == "nse" ? "data" : "Table";
    String percentCng = type == "nse" ? "percentChange" : "PERCENTCHG";
    // print("Index:");
    for (var entry in json.entries) {
      // print(entry.key);
      if (entry.key == compare) {
        // print("GOT IT");
        data = entry.value as List<dynamic>;
        for (var element in data) {
          ind = element as Map<String, dynamic>;
          Index index = Index(ind);
          indices.add(index);
        }
        break;
      }
    }
    indices.sort((a, b) => (double.parse(b.index[percentCng].toString())
        .compareTo(double.parse(a.index[percentCng].toString()))));

    return Indices(indices, type);
  }
}

class Index {
  final Map<String, dynamic> index;

  Index(this.index);
}
