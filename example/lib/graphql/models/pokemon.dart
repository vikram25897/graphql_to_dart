import 'package:example/graphql/models/pokemon_dimension.dart';
import 'package:example/graphql/models/pokemon_attack.dart';
import 'package:example/graphql/models/pokemon.dart';
import 'package:example/graphql/models/pokemon_evolution_requirement.dart';

class Pokemon {
  int id;
  String number;
  String name;
  PokemonDimension weight;
  PokemonDimension height;
  String classification;
  List<String> types;
  List<String> resistant;
  PokemonAttack attacks;
  List<String> weaknesses;
  double fleeRate;
  int maxCP;
  List<Pokemon> evolutions;
  PokemonEvolutionRequirement evolutionRequirements;
  int maxHP;
  String image;
  Pokemon(
      {this.id,
      this.number,
      this.name,
      this.weight,
      this.height,
      this.classification,
      this.types,
      this.resistant,
      this.attacks,
      this.weaknesses,
      this.fleeRate,
      this.maxCP,
      this.evolutions,
      this.evolutionRequirements,
      this.maxHP,
      this.image});

  Pokemon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    name = json['name'];
    weight = json['weight'] != null
        ? PokemonDimension.fromJson(json['weight'])
        : null;
    height = json['height'] != null
        ? PokemonDimension.fromJson(json['height'])
        : null;
    classification = json['classification'];
    types = json['types'] != null ? json['types'] : null;
    resistant = json['resistant'] != null ? json['resistant'] : null;
    attacks = json['attacks'] != null
        ? PokemonAttack.fromJson(json['attacks'])
        : null;
    weaknesses = json['weaknesses'] != null ? json['weaknesses'] : null;
    fleeRate = json['fleeRate'];
    maxCP = json['maxCP'];
    evolutions = json['evolutions'] != null
        ? List.generate(json['evolutions'].length,
            (index) => Pokemon.fromJson(json['evolutions'][index]))
        : null;
    evolutionRequirements = json['evolutionRequirements'] != null
        ? PokemonEvolutionRequirement.fromJson(json['evolutionRequirements'])
        : null;
    maxHP = json['maxHP'];
    image = json['image'];
  }

  Map toJson() {
    Map data = {};
    data['id'] = id;
    data['number'] = number;
    data['name'] = name;
    data['weight'] = weight?.toJson();
    data['height'] = height?.toJson();
    data['classification'] = classification;
    data['types'] = types;
    data['resistant'] = resistant;
    data['attacks'] = attacks?.toJson();
    data['weaknesses'] = weaknesses;
    data['fleeRate'] = fleeRate;
    data['maxCP'] = maxCP;
    data['evolutions'] = List.generate(
        evolutions?.length ?? 0, (index) => evolutions[index].toJson());
    data['evolutionRequirements'] = evolutionRequirements?.toJson();
    data['maxHP'] = maxHP;
    data['image'] = image;
    return data;
  }
}
