import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mk_mining/configs/urls.dart';
import 'package:mk_mining/models/check_mail_mod.dart';


Future<CheckMailModel> checkMailService(
    {required Map<String, String> payload}) async {
  debugPrint("call checkMailService");
  final Uri url = Uri.parse(AppUrls.checkEmailExist);
  final CheckMailModel checkMailModel = CheckMailModel();
  try {
    final response = await http.post(url, body: payload);
    if (response.statusCode == 200) {
      final checkMailModel2 = checkMailModelFromJson(response.body);
      final status = checkMailModel2.status;
      if (status != null && status == 1) {
        debugPrint("status in checkMailService: $status");
        return checkMailModel2;
      } else {
        debugPrint("status in checkMailService: $status");
        return checkMailModel2;
      }
    } else {
      debugPrint(
          "response.statusCode in checkMailService: ${response.statusCode}");
      checkMailModel.status = 0;
      checkMailModel.message = "Not found";
      return checkMailModel;
    }
  } on TimeoutException catch (e) {
        debugPrint("TimeoutException in checkMailService: $e");
        checkMailModel.status = 0;
      checkMailModel.message = "Time out";
      return checkMailModel;
      } on SocketException catch (e) {
        debugPrint("SocketException in checkMailService: $e");
        checkMailModel.status = 0;
      checkMailModel.message = "Internet connection failed";
      return checkMailModel;
      }
  catch (e) {
    debugPrint("exception in checkMailService: $e");
    checkMailModel.status = 0;
    checkMailModel.message = "Something went wrong";
    return checkMailModel;
  }
}