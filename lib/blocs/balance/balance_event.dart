part of 'balance_bloc.dart';

sealed class BalanceEvent extends Equatable {
  const BalanceEvent();

  @override
  List<Object> get props => [];
}

class FetchBalanceEvent extends BalanceEvent {
  final String token;
  const FetchBalanceEvent({required this.token});

  @override
  List<Object> get props => [token];
}
