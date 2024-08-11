import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokodek/core/theme/app_color.dart';
import 'package:pokodek/feature/detail_pokemon/logic/detail_pokemon_cubit.dart';
import 'package:pokodek/main.dart';

class DetailPokemonView extends StatefulWidget {
  const DetailPokemonView({super.key});

  @override
  State<DetailPokemonView> createState() => _DetailPokemonViewState();
}

class _DetailPokemonViewState extends State<DetailPokemonView> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return BlocBuilder<DetailPokemonCubit, DetailPokemonState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 32.0),
              Text(
                state.pokemon?.name ?? "Unknown Name",
                style: appTextTheme(context).titleLarge,
              ),
              const SizedBox(height: 16.0),
              Image.network(
                state.pokemon?.image ?? "",
                width: 150.0,
                height: 150.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 24.0),
            ],
          );
        },
      );
    }

    Widget detailAction() {
      return BlocBuilder<DetailPokemonCubit, DetailPokemonState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColor.primary[100],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    context.read<DetailPokemonCubit>().changePage(1);
                  },
                  child: Icon(
                    state.activePage == 1
                        ? Icons.account_box_rounded
                        : Icons.account_box_outlined,
                    color: AppColor.primary,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<DetailPokemonCubit>().changePage(2);
                  },
                  child: Icon(
                    state.activePage == 2
                        ? Icons.analytics_rounded
                        : Icons.analytics_outlined,
                    color: AppColor.primary,
                  ),
                )
              ],
            ),
          );
        },
      );
    }

    Widget biodataPokemon() {
      return BlocBuilder<DetailPokemonCubit, DetailPokemonState>(
        builder: (context, state) {
          return Container(
            color: AppColor.primary[100],
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.scale,
                              size: 48.0,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Minimum : ${state.pokemon?.weight?.minimum ?? 0}",
                                    style: appTextTheme(context).labelLarge,
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    "Maximum : ${state.pokemon?.weight?.maximum ?? 0}",
                                    style: appTextTheme(context).labelLarge,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.straight_rounded,
                              size: 48.0,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Minimum : ${state.pokemon?.height?.minimum ?? 0}",
                                    style: appTextTheme(context).labelLarge,
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    "Maximum : ${state.pokemon?.height?.maximum ?? 0}",
                                    style: appTextTheme(context).labelLarge,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),
                Text("Evolutions", style: appTextTheme(context).titleMedium),
                const SizedBox(height: 8.0),
                if (state.pokemon?.evolutions?.isNotEmpty ?? false)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: AppColor.primary,
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                        childAspectRatio: 96 / 118,
                      ),
                      itemCount: state.pokemon?.evolutions?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Image.network(
                              state.pokemon?.evolutions?[index].image ?? "",
                              width: 96.0,
                              height: 96.0,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              state.pokemon?.evolutions?[index].name ?? "",
                              style: appTextTheme(context).labelLarge,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      );
    }

    Widget statisticItem(
      String label,
      int value,
    ) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                label,
                style: appTextTheme(context).bodyMedium,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                value.toString(),
                style: appTextTheme(context).bodyMedium,
              ),
            ),
            Expanded(
              flex: 5,
              child: LinearProgressIndicator(
                value: value / 100,
                backgroundColor: AppColor.primary[200],
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColor.primary),
              ),
            ),
          ],
        ),
      );
    }

    Widget statistic() {
      return BlocBuilder<DetailPokemonCubit, DetailPokemonState>(
        builder: (context, state) {
          return Container(
            color: AppColor.primary[100],
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Text(
                  "Base Stast",
                  style: appTextTheme(context).titleLarge,
                ),
                const SizedBox(height: 8.0),
                ...List.generate(
                  state.pokemon?.attacks?.fast?.length ?? 0,
                  (index) => statisticItem(
                    state.pokemon!.attacks!.fast![index].name ?? "",
                    state.pokemon!.attacks!.fast![index].damage ?? 0,
                  ),
                ),
                ...List.generate(
                  state.pokemon?.attacks?.special?.length ?? 0,
                  (index) => statisticItem(
                    state.pokemon!.attacks!.special![index].name ?? "",
                    state.pokemon!.attacks!.special![index].damage ?? 0,
                  ),
                ),
                statisticItem(
                  "Max. CP",
                  state.pokemon?.maxCp ?? 0,
                ),
                statisticItem(
                  "Max. HP",
                  state.pokemon?.maxHp ?? 0,
                ),
              ],
            ),
          );
        },
      );
    }

    Widget body() {
      return BlocBuilder<DetailPokemonCubit, DetailPokemonState>(
        builder: (context, state) {
          return Expanded(
            child: state.activePage == 1 ? biodataPokemon() : statistic(),
          );
        },
      );
    }

    return Column(
      children: [
        header(),
        detailAction(),
        body(),
      ],
    );
  }
}
