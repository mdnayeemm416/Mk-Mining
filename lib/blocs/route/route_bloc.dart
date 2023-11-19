import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mk_mining/database/local_db.dart';
import 'package:mk_mining/models/sign_in_mod.dart';
import 'package:mk_mining/services/sign_in_ser.dart';

part 'route_event.dart';
part 'route_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  RouteBloc() : super(RouteInitial()) {
    on<DoRouteEvent>((event, emit) async {
      debugPrint("call DoRouteEvent");
      final loginInfo = await LocalDB.fetchLoginInfo();
      debugPrint(
          "loginInfo size: ${loginInfo == null ? '0' : loginInfo.length}");
      if (loginInfo == null || loginInfo.isEmpty) {
        emit(RouteLoginState());
        return;
      }

      //for login
      Map<String, String> payload = loginInfo[7].isEmpty ?
       {
        "email": loginInfo[0],
        "password": loginInfo[1]
      }:{
              "email": loginInfo[0],
              "name": loginInfo[2],
              "social_id": loginInfo[7]
            };
debugPrint("DoRouteEvent payload: $payload");
      final SignInModel result = await signInService(payload: payload, isGoogleSignIn:loginInfo[7].isEmpty ? false:true);

      if (result.status == 0) {
        emit(RouteLoginState());
        return;
      }

      final data = result.data;
      final balance = result.balance;
      if (data == null || balance == null) {
        emit( RouteLoginState());
        return;
      }


      //for received balance
      final mainBalance = balance.mainBalance ?? '';
      final miningBalance = balance.miningBalance ?? '';
      

      //for received token
      final token = data.token ?? '';

      final user = data.user;
      if (user == null) {
        emit(RouteLoginState());
        return;
      }

      if (user.isActive == "0") {
        emit(RouteLoginState());
        return;
      }

      await LocalDB.putLoginInfo(
          email: user.email ?? '',
          password: loginInfo[1],
          name: user.name ?? '',
          referCode: user.referCode ?? '',
          token: token,
          mainBalance: mainBalance,
          miningBalance: miningBalance,
          socialId: loginInfo[7],
          imgUrl: loginInfo[8]
          );

      emit(RouteHomeState());
    });
  }
}
