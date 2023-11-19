part of 'refer_bloc.dart';

sealed class ReferEvent extends Equatable {
  const ReferEvent();

  @override
  List<Object> get props => [];
}

class FetchReferUserEvent extends ReferEvent {
  final String token;
  const FetchReferUserEvent({required this.token});

  @override
  List<Object> get props => [token];
}
