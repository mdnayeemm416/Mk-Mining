import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_mining/blocs/sign_up/sign_up_bloc.dart';
import 'package:mk_mining/configs/colors.dart';
import 'package:mk_mining/configs/sizes.dart';
import 'package:mk_mining/views/auth/sign_in_scr.dart';
import 'package:mk_mining/widgets/app_alert_dialog.dart';
import 'package:mk_mining/widgets/app_loader.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key, required this.email});
  final String email;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController newPasswordCon = TextEditingController(text: '');
  final TextEditingController confirmPasswordCon =
      TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          appLoader(context);
        } else if (state is SignUpSuccess) {
          Navigator.pop(context);
          appAlertDialog(
              context, "Welcome", "Your new password is created successfully",
              actions: [
                CupertinoDialogAction(
                  child: const Text('Go to login'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (_) => const SignInScreen()));
                  },
                )
              ]);
        } else if (state is SignUpException) {
          appAlertDialog(context, "Warning", state.msg, actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ]);
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg.jpg"),
                    fit: BoxFit.cover)),
          ),
          ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.bodyPadding),
            children: [
              SizedBox(
                height: AppSizes.height(context) * 0.1,
              ),
              Image.asset(
                "assets/images/reset-password.png",
                height: AppSizes.width(context) * 0.25,
              ),
              SizedBox(
                height: AppSizes.height(context) * 0.1,
              ),
              Column(
                children: [
                  Text(
                    "Reset Password",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: AppSizes.width(context) * 0.07),
                  ),
                  const Text(
                    "Set the new password for your account so you can login and access all the feature",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              SizedBox(
                height: AppSizes.height(context) * 0.1,
              ),
              TextField(
                controller: newPasswordCon,
                decoration: InputDecoration(
                    hintText: "New Password",
                    filled: true,
                    isDense: true,
                    fillColor: AppColors.systemGrey3.withOpacity(0.3),
                    prefixIcon: const Icon(
                      CupertinoIcons.lock,
                    )),
              ),
              const SizedBox(
                height: AppSizes.bodyPadding,
              ),
              TextField(
                controller: confirmPasswordCon,
                decoration: InputDecoration(
                    hintText: "Confirm Password",
                    filled: true,
                    isDense: true,
                    fillColor: AppColors.systemGrey3.withOpacity(0.3),
                    prefixIcon: const Icon(
                      CupertinoIcons.lock,
                    )),
              ),
              SizedBox(
                height: AppSizes.height(context) * 0.1,
              ),
              CupertinoButton.filled(
                  onPressed: () {
                    context.read<SignUpBloc>().add(ForgotPasswordEvent(
                        email: widget.email,
                        newPassword: newPasswordCon.text,
                        confirmPassword: confirmPasswordCon.text));
                  },
                  child: const Text("Reset Password")),
            ],
          ),
        ],
      ),
    ));
  }
}
