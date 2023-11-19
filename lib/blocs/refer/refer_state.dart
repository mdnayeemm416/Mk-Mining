part of 'refer_bloc.dart';

sealed class ReferState extends Equatable {
  const ReferState();

  @override
  List<Object> get props => [];
}

final class ReferInitial extends ReferState {}

final class ReferLoadingState extends ReferState {}

final class ReferSuccessState extends ReferState {
  final List<ReferUser?> referUsers;
  const ReferSuccessState({required this.referUsers});

  @override
  List<Object> get props => [referUsers];
}

final class ReferFailedState extends ReferState {
  final String msg;
  const ReferFailedState({required this.msg});

  @override
  List<Object> get props => [msg];
}

final class ReferUserEmptyState extends ReferState {}
