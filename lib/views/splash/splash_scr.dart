import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_mining/blocs/route/route_bloc.dart';
import 'package:mk_mining/views/Tabbar/tabbar.dart';
import 'package:mk_mining/views/home/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RouteBloc>().add(DoRouteEvent());
    return Scaffold(
      body: BlocListener<RouteBloc, RouteState>(
        listener: (context, state) {
          if (state is RouteLoginState) {
            Navigator.pushReplacement(context,
                CupertinoPageRoute(builder: (_) => const TabbarWidget()));
          } else if (state is RouteHomeState) {
            Navigator.pushReplacement(context,
                CupertinoPageRoute(builder: (_) => const HomeScreen()));
          }
        },
        child: Center(
          child: Image.asset(
            "assets/images/logo.png",
            height: 40,
          ),
        ),
      ),
    );
  }
}
