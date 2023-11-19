import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_mining/blocs/sign_up/sign_up_bloc.dart';
import 'package:mk_mining/configs/colors.dart';
import 'package:mk_mining/configs/sizes.dart';
import 'package:mk_mining/views/auth/otp_scr.dart';
import 'package:mk_mining/widgets/app_alert_dialog.dart';
import 'package:mk_mining/widgets/app_loader.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailCon = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpLoading) {
            appLoader(context);
          } else if (state is SignUpSuccess) {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                    builder: (_) => OTPScreen(email: emailCon.text, fromForgotPassword: true)));
          } else if (state is SignUpException) {
            Navigator.pop(context);
            appAlertDialog(context, "Warning", state.msg, actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
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
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.bodyPadding),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: AppSizes.height(context) * 0.1,
                  ),
                  Image.asset(
                    "assets/images/email.png",
                    width: AppSizes.width(context) * 0.25,
                  ),
                  SizedBox(
                    height: AppSizes.height(context) * 0.1,
                  ),
                  Column(
                    children: [
                      Text(
                        "Enter Your Email Address",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: AppSizes.width(context) * 0.07),
                      ),
                      const Text(
                        "We will send you a confirmation code",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.height(context) * 0.1,
                  ),
                  TextField(
                    controller: emailCon,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "email",
                        filled: true,
                        isDense: true,
                        fillColor: AppColors.systemGrey3.withOpacity(0.3),
                        prefixIcon: const Icon(
                          CupertinoIcons.mail,
                        )),
                  ),
                  SizedBox(
                    height: AppSizes.height(context) * 0.1,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: CupertinoButton.filled(
                        onPressed: () {
                          context.read<SignUpBloc>().add(SendOtpEvent(
                              email: emailCon.text, fromForgotPassword: true, resend: false));
                        },
                        child: const Text("Verify")),
                  ),
                  SizedBox(
                    height: AppSizes.height(context) * 0.1,
                  ),
                  const Column(
                    children: [
                      Text(
                        "By continuing you agree to MK Mining",
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Terms of use",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                          Text(" & "),
                          Text(
                            "Privacy policy",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
