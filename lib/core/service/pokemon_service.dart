import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokodek/core/repositories/pokemon_response.dart';
import 'package:pokodek/core/service/pokemon_node.dart';
import 'package:pokodek/main.dart';

abstract class PokemonService {
  Future<List<Pokemon>> getPokemons({required int limitations});
  Future<Pokemon> getDetailPokemon({String? id});
  Future<List<Pokemon>> getAllData();
}

class PokemonServiceImpl implements PokemonService {
  final PokemonNode node;

  PokemonServiceImpl({required this.node});

  factory PokemonServiceImpl.create() {
    return PokemonServiceImpl(node: PokemonNode());
  }

  @override
  Future<List<Pokemon>> getPokemons({required int limitations}) async {
    final response = await client.value.query(
      QueryOptions(
        document: node.getListPokemons(limitations.toString()),
        parserFn: (Map<String, dynamic> data) {
          final pokemons = data["pokemons"];
          return (pokemons as List).map((e) => Pokemon.fromMap(e)).toList();
        },
      ),
    );

    return response.parsedData ?? [];
  }

  @override
  Future<Pokemon> getDetailPokemon({String? id}) async {
    final response = await client.value.query(
      QueryOptions(
        document: node.gePokemon(id ?? ""),
        parserFn: (Map<String, dynamic> data) {
          final pokemons = data["pokemon"];
          return Pokemon.fromMap(pokemons as Map<String, dynamic>);
        },
      ),
    );
    return response.parsedData ?? Pokemon();
  }

  @override
  Future<List<Pokemon>> getAllData() async {
    final response = await client.value.query(
      QueryOptions(
        document: node.getListPokemons("1000"),
        parserFn: (Map<String, dynamic> data) {
          final pokemons = data["pokemons"];
          return (pokemons as List).map((e) => Pokemon.fromMap(e)).toList();
        },
      ),
    );

    return response.parsedData ?? [];
  }
}
