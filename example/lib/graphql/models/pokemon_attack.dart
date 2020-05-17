import 'package:example/graphql/models/attack.dart';

class PokemonAttack {
  List<Attack> fast;
  List<Attack> special;
  PokemonAttack({this.fast, this.special});

  PokemonAttack.fromJson(Map<String, dynamic> json) {
    fast = json['fast'] != null
        ? List.generate(json['fast'].length,
            (index) => Attack.fromJson(json['fast'][index]))
        : null;
    special = json['special'] != null
        ? List.generate(json['special'].length,
            (index) => Attack.fromJson(json['special'][index]))
        : null;
  }

  Map toJson() {
    Map data = {};
    data['fast'] =
        List.generate(fast?.length ?? 0, (index) => fast[index].toJson());
    data['special'] =
        List.generate(special?.length ?? 0, (index) => special[index].toJson());
    return data;
  }
}
