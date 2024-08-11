import 'dart:convert';

class Pokemon {
  final String? id;
  final String? number;
  final String? name;
  final Eight? weight;
  final Eight? height;
  final String? classification;
  final List<String>? types;
  final List<String>? resistant;
  final Attacks? attacks;
  final List<String>? weaknesses;
  final double? fleeRate;
  final int? maxCp;
  final List<Pokemon>? evolutions;
  final EvolutionRequirements? evolutionRequirements;
  final int? maxHp;
  final String? image;

  Pokemon({
    this.id,
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
    this.maxCp,
    this.evolutions,
    this.evolutionRequirements,
    this.maxHp,
    this.image,
  });

  factory Pokemon.fromJson(String str) => Pokemon.fromMap(json.decode(str));

  factory Pokemon.fromMap(Map<String, dynamic> json) => Pokemon(
        id: json["id"],
        number: json["number"],
        name: json["name"],
        weight: json["weight"] == null ? null : Eight.fromMap(json["weight"]),
        height: json["height"] == null ? null : Eight.fromMap(json["height"]),
        classification: json["classification"],
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"]!.map((x) => x)),
        resistant: json["resistant"] == null
            ? []
            : List<String>.from(json["resistant"]!.map((x) => x)),
        attacks:
            json["attacks"] == null ? null : Attacks.fromMap(json["attacks"]),
        weaknesses: json["weaknesses"] == null
            ? []
            : List<String>.from(json["weaknesses"]!.map((x) => x)),
        fleeRate: json["fleeRate"]?.toDouble(),
        maxCp: json["maxCP"],
        evolutions: json["evolutions"] == null
            ? []
            : List<Pokemon>.from(
                json["evolutions"]!.map((x) => Pokemon.fromMap(x))),
        evolutionRequirements: json["evolutionRequirements"] == null
            ? null
            : EvolutionRequirements.fromMap(json["evolutionRequirements"]),
        maxHp: json["maxHP"],
        image: json["image"],
      );
}

class Attacks {
  final List<Fast>? fast;
  final List<Fast>? special;

  Attacks({
    this.fast,
    this.special,
  });

  factory Attacks.fromJson(String str) => Attacks.fromMap(json.decode(str));

  factory Attacks.fromMap(Map<String, dynamic> json) => Attacks(
        fast: json["fast"] == null
            ? []
            : List<Fast>.from(json["fast"]!.map((x) => Fast.fromMap(x))),
        special: json["special"] == null
            ? []
            : List<Fast>.from(json["special"]!.map((x) => Fast.fromMap(x))),
      );
}

class Fast {
  final String? name;
  final String? type;
  final int? damage;

  Fast({
    this.name,
    this.type,
    this.damage,
  });

  factory Fast.fromJson(String str) => Fast.fromMap(json.decode(str));

  factory Fast.fromMap(Map<String, dynamic> json) => Fast(
        name: json["name"],
        type: json["type"],
        damage: json["damage"],
      );
}

class EvolutionRequirements {
  final int? amount;
  final String? name;

  EvolutionRequirements({
    this.amount,
    this.name,
  });

  factory EvolutionRequirements.fromJson(String str) =>
      EvolutionRequirements.fromMap(json.decode(str));

  factory EvolutionRequirements.fromMap(Map<String, dynamic> json) =>
      EvolutionRequirements(
        amount: json["amount"],
        name: json["name"],
      );
}

class Eight {
  final String? minimum;
  final String? maximum;

  Eight({
    this.minimum,
    this.maximum,
  });

  factory Eight.fromJson(String str) => Eight.fromMap(json.decode(str));

  factory Eight.fromMap(Map<String, dynamic> json) => Eight(
        minimum: json["minimum"],
        maximum: json["maximum"],
      );
}
