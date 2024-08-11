part of 'try_graphql_cubit.dart';

class TryGraphqlState extends Equatable {
  const TryGraphqlState({
    this.status = GlobalState.initial,
    this.message = "",
  });

  final GlobalState status;
  final String message;

  TryGraphqlState copyWith({
    GlobalState? status,
    String? message,
  }) {
    return TryGraphqlState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
      ];
}
