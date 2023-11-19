import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mk_mining/services/check_mail_ser.dart';
import 'package:mk_mining/services/forgot_password_ser.dart';
import 'package:mk_mining/services/otp_send_ser.dart';
import 'package:mk_mining/services/sign_up_ser.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  String? name, email, phone, password, cPassword, referCode, optCode;
  SignUpBloc() : super(SignUpInitial()) {
    on<DoSignUpEvent>((event, emit) async {
      debugPrint("call DoSignUpEvent");
      // debugPrint("name: ${event.name}, email: ${event.email}, phone: ${event.phone}, password: ${event.password}, cPassword: ${event.cPassword}, refer code: ${event.referCode}");
      emit(SignUpLoading());
      if (event.email.trim().isEmpty &&
          event.name.trim().isEmpty &&
          event.password.trim().isEmpty) {
        emit(const SignUpException(msg: "Fill in the mandatory fields"));
        return;
      }

      if (event.name.trim().length < 3) {
        emit(const SignUpException(msg: "Please enter full name"));
        return;
      }

      if (!event.name.trim().startsWith(RegExp(r'^[a-zA-Z][a-zA-Z ]'))) {
        emit(const SignUpException(msg: "Name must start with a letter"));
        return;
      }

      if (!event.name.trim().startsWith(RegExp(r'^[a-zA-Z][a-zA-Z ]'))) {
        emit(const SignUpException(msg: "Name must start with a letter"));
        return;
      }

      if (event.phone.trim().isNotEmpty && event.phone.trim().length <= 9) {
        emit(
            const SignUpException(msg: "Number must be greater than 9-digits"));
        return;
      }

      if (event.phone.trim().contains(RegExp(r'^[a-zA-Z][a-zA-Z ]'))) {
        emit(const SignUpException(msg: "Number must be numeric"));
        return;
      }

      if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
          .hasMatch(event.email.trim())) {
        emit(const SignUpException(msg: "Please enter valid email"));
        return;
      }

      if (event.password.trim().length <= 5) {
        emit(const SignUpException(
            msg: "Password must be more than 5 characters"));
        return;
      }

      if (event.password != event.cPassword) {
        emit(const SignUpException(msg: "No two passwords are the same"));
        return;
      }

      //for check email
      final Map<String, String> checkMailPayload = {
        "email": event.email.trim()
      };
      final checkMail = await checkMailService(payload: checkMailPayload);
      if (checkMail.status == 0) {
        emit(SignUpException(msg: checkMail.message ?? "Email already used"));
        return;
      }
      //end for check email

      name = event.name;
      email = event.email;
      phone = event.phone;
      password = event.password;
      cPassword = event.cPassword;
      referCode = event.referCode;

      emit(SignUpSuccess());
    });

    //for otp send
    on<SendOtpEvent>((event, emit) async {
      debugPrint("call SendOtpEvent");
      if (event.fromForgotPassword) {
        emit(SignUpLoading());
        if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
            .hasMatch(event.email.trim())) {
          emit(const SignUpException(msg: "Please enter valid email"));
          return;
        }
      }
      final otp = await otpSendService(payload: {"email": event.email});
      if (otp.status == 0) {
        emit(SignUpException(msg: otp.message ?? "Failed to send otp"));
        return;
      }
      final otpData = otp.data;
      if (otpData == null) {
        emit(const SignUpException(msg: "Otp code not available"));
        return;
      }
      optCode = otpData.code.toString();

      if (event.fromForgotPassword && !event.resend) {
        emit(SignUpSuccess());
        return;
      }

      if (event.fromForgotPassword && event.resend) {
        emit(ResendOTPState());
      }
    });

    //for otp submit
    on<SubmitOtpEvent>((event, emit) async {
      debugPrint("call SubmitOtpEvent");
      emit(SignUpLoading());
      if (optCode != event.otpCode.trim().toString()) {
        emit(const SignUpException(msg: "Otp not matching"));
        return;
      }

      final Map<String, String> signUpPayload = {
        "name": name.toString(),
        "email": email.toString(),
        "phone": phone.toString(),
        "password": password.toString(),
        "is_active": '1',
        "by_refer_code": referCode.toString()
      };
      final signUpData = await signUpService(payload: signUpPayload);
      if (signUpData.status == 0) {
        emit(
            SignUpException(msg: signUpData.message ?? "Something went wrong"));
        return;
      }
      emit(SignUpSuccess());
    });

    //for forgot password
    on<ForgotPasswordEvent>((event, emit) async {
      debugPrint("call ForgotPasswordEvent");
      emit(SignUpLoading());
      if (event.newPassword.trim().length <= 5) {
        emit(const SignUpException(
            msg: "Password must be more than 5 characters"));
        return;
      }

      if (event.newPassword.trim() != event.confirmPassword.trim()) {
        emit(const SignUpException(msg: "No two passwords are the same"));
        return;
      }

      final Map<String, String> forgotPayload = {
        "email": event.email.trim(),
        "password": event.newPassword.trim(),
      };

      final forgotPassword =
          await forgotPasswordService(payload: forgotPayload);

      if (forgotPassword.status == 0) {
        emit(SignUpException(
            msg: forgotPassword.message ?? "Something went wrong"));
        return;
      }
      emit(SignUpSuccess());
    });

    //match otp for forgot password MatchOTPForgotPasswordEvent
    on<MatchOTPForgotPasswordEvent>((event, emit) async {
      debugPrint("call MatchOTPForgotPasswordEvent");
      emit(SignUpLoading());
      if (optCode != event.otp.trim().toString()) {
        emit(const SignUpException(msg: "Otp not matching"));
        return;
      }
      emit(SignUpSuccess());
    });
  }
}
