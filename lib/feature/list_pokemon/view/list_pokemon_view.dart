import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokodek/core/components/app_dialog.dart';
import 'package:pokodek/core/components/app_filter_widget.dart';
import 'package:pokodek/core/components/app_text_field.dart';
import 'package:pokodek/core/theme/app_color.dart';
import 'package:pokodek/core/utils/app_debounce.dart';
import 'package:pokodek/core/utils/app_lazy_load.dart';
import 'package:pokodek/core/utils/app_transition.dart';
import 'package:pokodek/core/utils/global_state.dart';
import 'package:pokodek/feature/detail_pokemon/view/detail_pokemon_page.dart';
import 'package:pokodek/feature/list_pokemon/logic/list_pokemon_cubit.dart';
import 'package:pokodek/main.dart';

class ListPokemonView extends StatefulWidget {
  const ListPokemonView({super.key});

  @override
  State<ListPokemonView> createState() => _ListPokemonViewState();
}

class _ListPokemonViewState extends State<ListPokemonView> {
  final TextEditingController searchController = TextEditingController();
  final AppLazyLoad _lazyLoad = AppLazyLoad();
  TextEditingController classificationController = TextEditingController();

  final AppDebounce _debounce = AppDebounce(const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    _lazyLoad.onListener(
      onLoadMore: () {
        if (!context.read<ListPokemonCubit>().state.isLastIndex) {
          context.read<ListPokemonCubit>().onLoadMore();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget searchField() {
      return Row(
        children: [
          Expanded(
              child: AppSearchField(
            controller: searchController,
            onChanged: (String value) {
              _debounce.call(() {
                context.read<ListPokemonCubit>().searchPokemonByName(value);
              });
            },
            fillColor: AppColor.primary[100],
          )),
          const SizedBox(width: 8.0),
          AppFilterWidget(
            () async {
              await showDialog(
                context: context,
                builder: (_) {
                  return AppDialog.defaultDialog(
                    context,
                    "Filter data",
                    child: Column(
                      children: [
                        AppDropdownTextField(
                          "Classification",
                          context
                              .read<ListPokemonCubit>()
                              .state
                              .pokemonClassification,
                          classificationController,
                          isMandatory: true,
                          hint: "Pilih salah satu",
                          onChanged: (value) {
                            classificationController.text = value;
                            context
                                .read<ListPokemonCubit>()
                                .onFilterPokemonByClassification(value);
                            Navigator.of(context).pop();
                          },
                        ),
                        const SizedBox(height: 24.0),
                      ],
                    ),
                  );
                },
              );
            },
            color: AppColor.primary[100],
          ),
        ],
      );
    }

    Widget pokemonItem() {
      return BlocBuilder<ListPokemonCubit, ListPokemonState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          if (state.status.isFailed) {
            return Center(
              child: Text(state.errorMessage),
            );
          }

          return ListView.builder(
            controller: _lazyLoad.controller,
            itemCount: state.pokemons.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(AppTransition.pushTransition(
                    DetailPokemonPage(state.pokemons[index].id ?? ""),
                    DetailPokemonPage.routeSettings,
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  color: AppColor.primary[300],
                  margin: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      Container(
                        height: 35.0,
                        width: 35.0,
                        decoration: BoxDecoration(
                          color: AppColor.primary[200],
                          borderRadius: BorderRadius.circular(12.0),
                          image: DecorationImage(
                            onError: (exception, stackTrace) {
                              const Icon(Icons.error);
                            },
                            fit: BoxFit.cover,
                            image:
                                NetworkImage(state.pokemons[index].image ?? ""),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.pokemons[index].name ?? "",
                              style: appTextTheme(context).titleMedium,
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              "Classifications : ${state.pokemons[index].classification ?? ""}",
                              style: appTextTheme(context).bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    }

    Widget onLoadMore() {
      return BlocBuilder<ListPokemonCubit, ListPokemonState>(
        builder: (context, state) {
          return AppLoadMoreWidget(status: state.status.isLoadMore);
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          const SizedBox(height: kToolbarHeight),
          searchField(),
          const SizedBox(height: 16.0),
          Expanded(child: pokemonItem()),
          onLoadMore(),
        ],
      ),
    );
  }
}
