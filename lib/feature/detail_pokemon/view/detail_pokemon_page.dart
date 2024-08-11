import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokodek/core/service/pokemon_service.dart';
import 'package:pokodek/core/utils/global_state.dart';
import 'package:pokodek/feature/detail_pokemon/logic/detail_pokemon_cubit.dart';
import 'package:pokodek/feature/detail_pokemon/view/detail_pokemon_view.dart';

class DetailPokemonPage extends StatelessWidget {
  const DetailPokemonPage(this.id, {super.key});

  final String id;

  static const RouteSettings routeSettings =
      RouteSettings(name: '/detail-pokemon-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            DetailPokemonCubit(PokemonServiceImpl.create())..init(id),
        child: BlocBuilder<DetailPokemonCubit, DetailPokemonState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            if (state.status.isFailed) {
              return Center(child: Text(state.errorMessage));
            }

            return DetailPokemonView();
          },
        ),
      ),
    );
  }
}
