part of 'list_pokemon_cubit.dart';

class ListPokemonState extends Equatable {
  const ListPokemonState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
    this.lastIndex = 10,
    this.pokemons = const [],
    this.isLastIndex = false,
    this.pokemonClassification = const [],
    this.allPokemons = const [],
  });

  final GlobalState status;
  final String errorMessage;
  final int lastIndex;
  final List<Pokemon> pokemons;
  final bool isLastIndex;
  final List<String> pokemonClassification;
  final List<Pokemon> allPokemons;

  ListPokemonState copyWith({
    GlobalState? status,
    String? errorMessage,
    int? lastIndex,
    List<Pokemon>? pokemons,
    bool? isLastIndex,
    final List<String>? pokemonClassification,
    final List<Pokemon>? allPokemons,
  }) {
    return ListPokemonState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      lastIndex: lastIndex ?? this.lastIndex,
      pokemons: pokemons ?? this.pokemons,
      isLastIndex: isLastIndex ?? this.isLastIndex,
      pokemonClassification:
          pokemonClassification ?? this.pokemonClassification,
      allPokemons: allPokemons ?? this.allPokemons,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        lastIndex,
        pokemons,
        isLastIndex,
        pokemonClassification,
        allPokemons,
      ];
}
