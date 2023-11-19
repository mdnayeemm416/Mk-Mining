part of 'balance_bloc.dart';

sealed class BalanceState extends Equatable {
  const BalanceState();

  @override
  List<Object> get props => [];
}

final class BalanceInitial extends BalanceState {}

final class BalanceSuccessState extends BalanceState {
  final String mainBalance, miningBalance;
  const BalanceSuccessState(
      {required this.mainBalance, required this.miningBalance});
      @override
  List<Object> get props => [mainBalance,miningBalance];
}

final class BalanceFailedState extends BalanceState {}
