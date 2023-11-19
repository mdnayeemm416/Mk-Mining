part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class DoSignInEvent extends SignInEvent {
  final String email, password, name, socialId, imgUrl;
  const DoSignInEvent(
      {required this.email,
      required this.password,
      required this.name,
      required this.socialId,
      required this.imgUrl});
  @override
  List<Object> get props => [email, password, name, socialId, imgUrl];
}

