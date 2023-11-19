import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mk_mining/models/refer_user_mod.dart';
import 'package:mk_mining/services/refer_user_ser.dart';

part 'refer_event.dart';
part 'refer_state.dart';

class ReferBloc extends Bloc<ReferEvent, ReferState> {
  ReferBloc() : super(ReferInitial()) {
    on<FetchReferUserEvent>((event, emit) async {
      debugPrint("call FetchReferUserEvent");
      emit(ReferLoadingState());
      final result = await referUserService(token: event.token);

      if (result.status == 0) {
        emit(ReferFailedState(msg: result.message ?? 'Something went wrong'));
        return;
      }

      final data = result.data;
      if (data == null) {
        emit(ReferFailedState(msg: result.message ?? 'Data is null'));
        return;
      }

      final referUserList = data.map((e) => e.referUser).toList();

      if (referUserList.isEmpty) {
        debugPrint("referUserList size1: ${referUserList.length}");
        emit(ReferUserEmptyState());
        return;
      }

      debugPrint("referUserList size2: ${referUserList.length}");

      emit(ReferSuccessState(referUsers: referUserList));
    });
  }
}
