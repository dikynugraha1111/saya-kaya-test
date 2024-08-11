import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokodek/core/exception/app_exception.dart';
import 'package:pokodek/core/repositories/pokemon_response.dart';
import 'package:pokodek/core/service/pokemon_service.dart';
import 'package:pokodek/core/utils/global_state.dart';
part 'detail_pokemon_state.dart';

class DetailPokemonCubit extends Cubit<DetailPokemonState> {
  DetailPokemonCubit(this.service) : super(const DetailPokemonState());

  final PokemonService service;

  Future<void> init(String id) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getDetailPokemon(id: id);
      emit(state.copyWith(
        status: GlobalState.loaded,
        pokemon: response,
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

  void changePage(int page) {
    emit(state.copyWith(status: GlobalState.changedLoading));
    emit(state.copyWith(activePage: page, status: GlobalState.loaded));
  }
}
