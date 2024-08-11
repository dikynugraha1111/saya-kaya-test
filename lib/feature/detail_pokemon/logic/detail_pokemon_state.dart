part of 'detail_pokemon_cubit.dart';

class DetailPokemonState extends Equatable {
  const DetailPokemonState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
    this.pokemon,
    this.activePage = 1,
  });

  final GlobalState status;
  final String errorMessage;
  final Pokemon? pokemon;
  final int activePage;

  DetailPokemonState copyWith({
    GlobalState? status,
    String? errorMessage,
    Pokemon? pokemon,
    int? activePage,
  }) {
    return DetailPokemonState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      pokemon: pokemon ?? this.pokemon,
      activePage: activePage ?? this.activePage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        pokemon,
        activePage,
      ];
}
