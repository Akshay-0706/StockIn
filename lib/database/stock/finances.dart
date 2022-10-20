class Finances {
  final List<Map<String, dynamic>> finance;

  Finances(this.finance);

  factory Finances.fromJson(List<dynamic> json) {
    List<Map<String, dynamic>> finances = [];
    // print(json);
    for (var element in json) {
      finances.add(element as Map<String, dynamic>);
    }
    // for (var entry in json.entries) {
    //   print(entry.key);
    // if (entry.key == "timeseries") {
    //   // print("GOT IT");
    //   data = entry.value as Map<String, dynamic>;
    //   for (var element in data.entries) {
    //     if(element.key == "result")
    //     // finance = element as Map<String, dynamic>;
    //     finances.add(element.value as Map<String, dynamic>);
    //   }
    //   break;
    // }
    // }

    // print("Finances: ");
    // print(finances);
    // indices.sort((a, b) => (double.parse(b.index[percentCng].toString())
    //     .compareTo(double.parse(a.index[percentCng].toString()))));

    return Finances(finances);
  }
}
