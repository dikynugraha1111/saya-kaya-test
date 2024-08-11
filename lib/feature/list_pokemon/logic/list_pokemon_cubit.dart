import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokodek/core/exception/app_exception.dart';
import 'package:pokodek/core/repositories/pokemon_response.dart';
import 'package:pokodek/core/service/pokemon_service.dart';
import 'package:pokodek/core/utils/global_state.dart';

part 'list_pokemon_state.dart';

class ListPokemonCubit extends Cubit<ListPokemonState> {
  ListPokemonCubit(this.service) : super(const ListPokemonState());

  final PokemonService service;
  List<Pokemon> tempPokemons = [];

  Future<void> init({bool isNeedGetAllData = true}) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getPokemons(limitations: state.lastIndex);
      if (isNeedGetAllData) getPokemonClassification();
      tempPokemons = response;
      emit(state.copyWith(
        status: GlobalState.loaded,
        pokemons: response,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: GlobalState.failed,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GlobalState.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> getPokemonClassification() async {
    final getAllData = await service.getAllData();
    List<String> pokemonClassification =
        getAllData.map((e) => e.classification ?? "").toList();
    pokemonClassification = pokemonClassification.toSet().toList();
    pokemonClassification = ["None", ...pokemonClassification];
    emit(state.copyWith(
      pokemonClassification: pokemonClassification,
      allPokemons: getAllData,
    ));
  }

  Future<void> onLoadMore() async {
    try {
      if (!state.isLastIndex) {
        emit(state.copyWith(status: GlobalState.loadMore));
        final response = await service.getPokemons(
          limitations: state.lastIndex + 5,
        );
        int currentlyLength = response.length;
        List<Pokemon> customPickedRange = response.sublist(
          state.lastIndex - 1,
          currentlyLength - 1,
        );
        bool isLarstIndex = currentlyLength < state.lastIndex + 5;
        tempPokemons = [...response, ...customPickedRange];
        emit(state.copyWith(
          status: GlobalState.loaded,
          pokemons: [...response, ...customPickedRange],
          lastIndex: currentlyLength,
          isLastIndex: isLarstIndex,
        ));
      }
    } on AppException catch (e) {
      emit(state.copyWith(
        status: GlobalState.failed,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GlobalState.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> onFilterPokemonByClassification(String classification) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      if (classification.toLowerCase() == "none") {
        emit(state.copyWith(
          status: GlobalState.loaded,
          pokemons: tempPokemons,
          isLastIndex: false,
        ));
      } else {
        final filteredPokemon = state.allPokemons
            .where((element) =>
                element.classification?.toLowerCase() ==
                classification.toLowerCase())
            .toList();
        emit(state.copyWith(
          status: GlobalState.loaded,
          pokemons: filteredPokemon,
          isLastIndex: true,
        ));
      }
    } on AppException catch (e) {
      emit(state.copyWith(
        status: GlobalState.failed,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GlobalState.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> searchPokemonByName(String name) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      if (name.isEmpty) {
        emit(state.copyWith(
          status: GlobalState.loaded,
          pokemons: tempPokemons,
          isLastIndex: false,
        ));
      } else {
        final filteredPokemon = state.allPokemons
            .where((element) =>
                (element.name ?? "").toLowerCase().contains(name.toLowerCase()))
            .toList();
        emit(state.copyWith(
          status: GlobalState.loaded,
          pokemons: filteredPokemon,
          isLastIndex: true,
        ));
      }
    } on AppException catch (e) {
      emit(state.copyWith(
        status: GlobalState.failed,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GlobalState.failed,
        errorMessage: e.toString(),
      ));
    }
  }
}
