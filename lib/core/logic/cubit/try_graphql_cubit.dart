import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokodek/core/utils/global_state.dart';
import 'package:pokodek/main.dart';

part 'try_graphql_state.dart';

class TryGraphqlCubit extends Cubit<TryGraphqlState> {
  TryGraphqlCubit() : super(const TryGraphqlState());

  Future<void> tryGraphql() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final query = gql(r"""
     {
    pokemons(first:100){
      name
      attacks{
        fast{
          damage
        }
      }
      classification
      types
      resistant
      
    }
  }
""");
      final response = await client.value.query(
        QueryOptions(
          document: query,
        ),
      );
      if (response.hasException) {
        print(response.exception.toString());
      }

      final responseData = response.data;

      log("Data response => ${response.data?["pokemons"]}");
    } catch (e) {
      log("Error => ${e.toString()}");
      emit(state.copyWith(status: GlobalState.failed, message: e.toString()));
    }
  }
}
