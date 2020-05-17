class PokemonDimension {
  String minimum;
  String maximum;
  PokemonDimension({this.minimum, this.maximum});

  PokemonDimension.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'];
    maximum = json['maximum'];
  }

  Map toJson() {
    Map data = {};
    data['minimum'] = minimum;
    data['maximum'] = maximum;
    return data;
  }
}
