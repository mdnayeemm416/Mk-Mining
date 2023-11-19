import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_mining/blocs/sign_in/sign_in_bloc.dart';
import 'package:mk_mining/configs/sizes.dart';
import 'package:mk_mining/utilities/google_tools.dart';
import 'package:mk_mining/views/auth/forgot_password_scr.dart';

import 'package:mk_mining/views/home/home.dart';
import 'package:mk_mining/widgets/app_alert_dialog.dart';
import 'package:mk_mining/widgets/app_loader.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();

  bool passwordOb = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInLoading) {
            appLoader(context);
          } else if (state is SignInSuccess) {
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                CupertinoPageRoute(builder: (_) => const HomeScreen()));
          } else if (state is SignInException) {
            appAlertDialog(context, "Warning", state.message, actions: [
              CupertinoDialogAction(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
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
                    height: AppSizes.height(context) * 0.09,
                  ),
                  //for input & title
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Start for"),
                      Text(
                        "Login to your account.\n",
                        style: TextStyle(
                            fontSize: AppSizes.width(context) * 0.07,
                            fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: emailCon,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)),
                            hintText: "email",
                            filled: true,
                            isDense: true,
                            fillColor: Colors.orange.shade100,
                            prefixIcon: const Icon(CupertinoIcons.mail)),
                      ),
                      const SizedBox(
                        height: AppSizes.bodyPadding,
                      ),
                      TextField(
                        obscureText: passwordOb,
                        controller: passwordCon,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30)),
                          hintText: "password",
                          filled: true,
                          isDense: true,
                          fillColor: Colors.orange.shade100,
                          prefixIcon: const Icon(CupertinoIcons.lock),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passwordOb = !passwordOb;
                              });
                            },
                            child: Icon(passwordOb
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: CupertinoButton(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: const Text("Forgot password?"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (_) =>
                                            const ForgotPasswordScreen()));
                              }))
                    ],
                  ),
                  //for input & title
                  SizedBox(
                    height: AppSizes.height(context) * 0.09,
                  ),

                  //for button
                  Column(
                    children: [
                      SizedBox(
                        width: AppSizes.width(context),
                        child: CupertinoButton.filled(
                            onPressed: () {
                              context.read<SignInBloc>().add(DoSignInEvent(
                                  email: emailCon.text,
                                  password: passwordCon.text,
                                  name: '',
                                  socialId: '',
                                  imgUrl: ''));
                            },
                            child: const Text("Login my account")),
                      ),
                      const SizedBox(
                        height: AppSizes.bodyPadding * 2,
                      ),
                      SizedBox(
                        width: AppSizes.width(context),
                        child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.radius))),
                            onPressed: () {
                              handleSignIn().then((value) {
                                if (value == null) {
                                  appAlertDialog(context, "Warning",
                                      "Something went wrong",
                                      actions: [
                                        CupertinoDialogAction(
                                          child: const Text("OK"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ]);
                                  return;
                                }
                                context.read<SignInBloc>().add(DoSignInEvent(
                                    email: value[0] ?? '',
                                    password: '',
                                    name: value[1] ?? '',
                                    socialId: value[2] ?? '',
                                    imgUrl: value[3] ?? ''));
                              });
                            },
                            icon: Image.asset(
                              "assets/images/search.png",
                              height: 16,
                              width: 16,
                            ),
                            label: const Text("Continue with google")),
                      )
                    ],
                  ),
                  //for button
                  SizedBox(
                    height: AppSizes.height(context) * 0.07,
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
