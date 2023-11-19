part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class DoSignUpEvent extends SignUpEvent {
  final String name, email, phone, password, cPassword, referCode;
  const DoSignUpEvent(
      {required this.name,
      required this.email,
      required this.phone,
      required this.password,
      required this.cPassword,
      required this.referCode});
  @override
  List<Object> get props =>
      [name, email, phone, password, cPassword, referCode];
}

class SendOtpEvent extends SignUpEvent {
  final String email;
  final bool fromForgotPassword, resend;
  const SendOtpEvent({required this.email, required this.fromForgotPassword, required this.resend});
  @override
  List<Object> get props => [email, fromForgotPassword, resend];
}

class SubmitOtpEvent extends SignUpEvent {
  final String otpCode;
  const SubmitOtpEvent({required this.otpCode});
  @override
  List<Object> get props => [otpCode];
}

class ForgotPasswordEvent extends SignUpEvent {
  final String email, newPassword, confirmPassword;
  const ForgotPasswordEvent(
      {required this.email,
      required this.newPassword,
      required this.confirmPassword});
  @override
  List<Object> get props =>
      [email, newPassword, confirmPassword]; //now create bloc
}

class MatchOTPForgotPasswordEvent extends SignUpEvent {
  final String otp;
  const MatchOTPForgotPasswordEvent({required this.otp});
  @override
  List<Object> get props => [otp];
}
