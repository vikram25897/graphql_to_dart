class PokemonEvolutionRequirement {
  int amount;
  String name;
  PokemonEvolutionRequirement({this.amount, this.name});

  PokemonEvolutionRequirement.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    name = json['name'];
  }

  Map toJson() {
    Map data = {};
    data['amount'] = amount;
    data['name'] = name;
    return data;
  }
}
