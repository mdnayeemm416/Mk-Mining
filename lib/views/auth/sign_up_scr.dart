import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_mining/blocs/sign_up/sign_up_bloc.dart';
import 'package:mk_mining/configs/colors.dart';
import 'package:mk_mining/configs/sizes.dart';
import 'package:mk_mining/views/auth/otp_scr.dart';
import 'package:mk_mining/widgets/app_alert_dialog.dart';
import 'package:mk_mining/widgets/app_loader.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameCon = TextEditingController(text: '');
  final TextEditingController emailCon = TextEditingController(text: '');
  final TextEditingController phoneCon = TextEditingController(text: '');
  final TextEditingController passwordCon = TextEditingController(text: '');
  final TextEditingController cPasswordCon = TextEditingController(text: '');
  final TextEditingController referCon = TextEditingController(text: '');
  bool hPassword = true;
  bool hCPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpLoading) {
            appLoader(context);
          } else if (state is SignUpSuccess) {
            Navigator.pop(context);
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (_) => OTPScreen(
                          email: emailCon.text,
                          fromForgotPassword: false,
                        )));
          } else if (state is SignUpException) {
            Navigator.pop(context);
            appAlertDialog(context, "Warning", state.msg, actions: [
              CupertinoDialogAction(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ]);
          }
        },
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(color: Colors.orange.shade50),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.bodyPadding),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppSizes.height(context) * 0.07,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create a new account.",
                        style: TextStyle(
                            fontSize: AppSizes.width(context) * 0.07,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "After creating an account you will get 500 coins",
                        style: TextStyle(color: AppColors.hint),
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.height(context) * 0.05,
                  ),

                  //for input & title
                  Column(
                    children: [
                      TextField(
                        controller: nameCon,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)),
                            hintText: "Name*",
                            filled: true,
                            isDense: true,
                            fillColor: Colors.orange.shade100,
                            prefixIcon: const Icon(CupertinoIcons.person)),
                      ),
                      const SizedBox(
                        height: AppSizes.bodyPadding,
                      ),
                      TextField(
                        controller: emailCon,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30)),
                          hintText: "Email*",
                          filled: true,
                          isDense: true,
                          fillColor: Colors.orange.shade100,
                          prefixIcon: const Icon(CupertinoIcons.mail),
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.bodyPadding,
                      ),
                      TextField(
                        controller: phoneCon,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30)),
                          hintText: "Phone",
                          filled: true,
                          isDense: true,
                          fillColor: Colors.orange.shade100,
                          prefixIcon: const Icon(CupertinoIcons.phone),
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.bodyPadding,
                      ),
                      TextField(
                        controller: passwordCon,
                        obscureText: hPassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30)),
                          hintText: "Password*",
                          filled: true,
                          isDense: true,
                          fillColor: Colors.orange.shade100,
                          prefixIcon: const Icon(CupertinoIcons.lock),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                hPassword = !hPassword;
                              });
                            },
                            child: Icon(hPassword
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.bodyPadding,
                      ),
                      TextField(
                        controller: cPasswordCon,
                        obscureText: hCPassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30)),
                          hintText: "Confirm password*",
                          filled: true,
                          isDense: true,
                          fillColor: Colors.orange.shade100,
                          prefixIcon: const Icon(CupertinoIcons.lock),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                hCPassword = !hCPassword;
                              });
                            },
                            child: Icon(hCPassword
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.bodyPadding,
                      ),
                      TextField(
                        controller: referCon,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30)),
                          hintText: "Refer code",
                          filled: true,
                          isDense: true,
                          fillColor: Colors.orange.shade100,
                          prefixIcon: const Icon(CupertinoIcons.tag),
                        ),
                      ),
                    ],
                  ),
                  //for input & title
                  SizedBox(
                    height: AppSizes.height(context) * 0.08,
                  ),

                  //for button
                  SizedBox(
                    width: AppSizes.width(context),
                    child: CupertinoButton.filled(
                        onPressed: () {
                          context.read<SignUpBloc>().add(DoSignUpEvent(
                              name: nameCon.text,
                              email: emailCon.text,
                              phone: phoneCon.text,
                              password: passwordCon.text,
                              cPassword: cPasswordCon.text,
                              referCode: referCon.text));
                        },
                        child: const Text("Create a account")),
                  ),
                  //for button
                  const SizedBox(
                    height: AppSizes.bodyPadding,
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
