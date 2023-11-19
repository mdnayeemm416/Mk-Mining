import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mk_mining/blocs/balance/balance_bloc.dart';
import 'package:mk_mining/blocs/refer/refer_bloc.dart';
import 'package:mk_mining/blocs/route/route_bloc.dart';
import 'package:mk_mining/blocs/sign_in/sign_in_bloc.dart';
import 'package:mk_mining/blocs/sign_up/sign_up_bloc.dart';
import 'package:mk_mining/configs/colors.dart';
import 'package:mk_mining/views/splash/splash_scr.dart';
import 'package:path_provider/path_provider.dart';

//for internet
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
//end internet

void main() async{
  //for internet
  HttpOverrides.global = MyHttpOverrides();
  //end internet

  //for local db
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  //end local db

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(),
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider<ReferBloc>(
          create: (context) => ReferBloc(),
        ),
        BlocProvider<RouteBloc>(
          create: (context) => RouteBloc(),
        ),
        BlocProvider<BalanceBloc>(
          create: (context) => BalanceBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seed),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

