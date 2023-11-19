import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_mining/blocs/sign_up/sign_up_bloc.dart';
import 'package:mk_mining/configs/colors.dart';
import 'package:mk_mining/configs/sizes.dart';
import 'package:mk_mining/views/auth/new_password_scr.dart';
import 'package:mk_mining/views/auth/sign_in_scr.dart';
import 'package:mk_mining/widgets/app_alert_dialog.dart';
import 'package:mk_mining/widgets/app_loader.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen(
      {super.key, required this.email, required this.fromForgotPassword});
  final String email;
  final bool fromForgotPassword;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final OtpFieldController otpCon = OtpFieldController();
  @override
  void initState() {
    debugPrint("widget.fromForgotPassword: ${widget.fromForgotPassword}");
    if (!widget.fromForgotPassword) {
      context.read<SignUpBloc>().add(SendOtpEvent(
          email: widget.email, fromForgotPassword: widget.fromForgotPassword, resend: false));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpLoading) {
            appLoader(context);
          } else if(state is ResendOTPState){
            Navigator.pop(context);
          }
          else if (state is SignUpSuccess) {
            Navigator.pop(context);
            if (widget.fromForgotPassword) {
              Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                      builder: (_) => NewPasswordScreen(
                            email: widget.email,
                          )));
            } else {
              appAlertDialog(
                  context, "Welcome", "Your account is created successfully",
                  actions: [
                    CupertinoDialogAction(
                        child: const Text('Go to login'),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                  builder: (_) => const SignInScreen()));
                        })
                  ]);
            }
          } else if (state is SignUpException) {
            Navigator.pop(context);
            appAlertDialog(context, "Warning", state.msg, actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                  if (!widget.fromForgotPassword) {
                    Navigator.pop(context);
                  }
                },
              )
            ]);
          }
        },
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.jpg"),
                  fit: BoxFit.cover)),
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.bodyPadding),
            children: [
              SizedBox(
                height: AppSizes.height(context) * 0.1,
              ),
              Image.asset(
                "assets/images/password.png",
                height: AppSizes.width(context) * 0.25,
              ),
              SizedBox(
                height: AppSizes.height(context) * 0.1,
              ),
              Column(
                children: [
                  Text(
                    "Enter Verification Code",
                    style: TextStyle(fontSize: AppSizes.width(context) * 0.07),
                  ),
                  Text(
                    "We are automatically detecting a mail sent to your email address *****${widget.email.substring(5)}",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              SizedBox(
                height: AppSizes.height(context) * 0.1,
              ),

              //for otp code
              OTPTextField(
                controller: otpCon,
                length: 4,
                width: double.maxFinite,
                fieldWidth: 50,
                style: const TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                otpFieldStyle: OtpFieldStyle(focusBorderColor: AppColors.seed),
                onCompleted: (pin) {
                  if (widget.fromForgotPassword) {
                    context
                        .read<SignUpBloc>()
                        .add(MatchOTPForgotPasswordEvent(otp: pin));
                  } else {
                    context
                        .read<SignUpBloc>()
                        .add(SubmitOtpEvent(otpCode: pin));
                  }
                },
              ),
              //end for otp code

              SizedBox(
                height: AppSizes.height(context) * 0.1,
              ),

              CupertinoButton(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't receive the OTP?",
                        style: TextStyle(color: AppColors.black),
                      ),
                      Text(" Resend OTP"),
                    ],
                  ),
                  onPressed: () {
                    otpCon.clear();
                    //new event for resend
                    context.read<SignUpBloc>().add(SendOtpEvent(
                        email: widget.email,
                        fromForgotPassword: widget.fromForgotPassword,
                        resend: true));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
