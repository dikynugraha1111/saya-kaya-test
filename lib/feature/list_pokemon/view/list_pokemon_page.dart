import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokodek/core/service/pokemon_service.dart';
import 'package:pokodek/feature/list_pokemon/logic/list_pokemon_cubit.dart';
import 'package:pokodek/feature/list_pokemon/view/list_pokemon_view.dart';

class ListPokemonPage extends StatelessWidget {
  const ListPokemonPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/list-pokemon-page');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ListPokemonCubit(PokemonServiceImpl.create())..init(),
      child: const Scaffold(
        body: ListPokemonView(),
      ),
    );
  }
}
