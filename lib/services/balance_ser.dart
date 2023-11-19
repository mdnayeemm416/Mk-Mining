import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mk_mining/configs/urls.dart';
import 'package:mk_mining/models/balance_mod.dart';

Future<BalanceModel> balanceService({required String token}) async {
  debugPrint("call balanceService");
  final Uri url = Uri.parse(AppUrls.getBalance);
  final BalanceModel balanceModel = BalanceModel();
  try {
    final response = await http
        .post(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    if (response.statusCode == 200) {
      final balanceModel2 = balanceModelFromJson(response.body);
      final status = balanceModel2.status;
      if (status != null && status == 1) {
        debugPrint("status in balanceService: $status");
        return balanceModel2;
      } else {
        debugPrint("status in balanceService: $status");
        return balanceModel2;
      }
    } else {
      debugPrint(
          "response.statusCode in balanceService: ${response.statusCode}");
      balanceModel.status = 0;
      balanceModel.message = "Not found";
      balanceModel.data = null;
      return balanceModel;
    }
  } on TimeoutException catch (e) {
    debugPrint("TimeoutException in balanceService: $e");
    balanceModel.status = 0;
    balanceModel.message = "Time out";
    balanceModel.data = null;
    return balanceModel;
  } on SocketException catch (e) {
    debugPrint("SocketException in balanceService: $e");
    balanceModel.status = 0;
    balanceModel.message = "Internet connection failed";
    balanceModel.data = null;
    return balanceModel;
  } catch (e) {
    debugPrint("exception in balanceService: $e");
    balanceModel.status = 0;
    balanceModel.message = "Something went wrong";
    balanceModel.data = null;
    return balanceModel;
  }
}
