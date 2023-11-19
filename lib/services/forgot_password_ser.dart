import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mk_mining/configs/urls.dart';
import 'package:mk_mining/models/forgot_password_mod.dart';

Future<ForgotPasswordModel> forgotPasswordService(
    {required Map<String, String> payload}) async {
  debugPrint("call forgotPasswordService");
  final Uri url = Uri.parse(AppUrls.forgotPassword);
  final ForgotPasswordModel forgotPasswordModel = ForgotPasswordModel();
  try {
    final response = await http.post(url, body: payload);
    if (response.statusCode == 200) {
      final forgotPasswordModel2 = forgotPasswordModelFromJson(response.body);
      final status = forgotPasswordModel2.status;
      if (status != null && status == 1) {
        debugPrint("status in forgotPasswordService: $status");
        return forgotPasswordModel2;
      } else {
        debugPrint("status in forgotPasswordService: $status");
        return forgotPasswordModel2;
      }
    } else {
      debugPrint(
          "response.statusCode in forgotPasswordService: ${response.statusCode}");
      forgotPasswordModel.status = 0;
      forgotPasswordModel.message = "Not found";
      return forgotPasswordModel;
    }
  } on TimeoutException catch (e) {
    debugPrint("TimeoutException in forgotPasswordService: $e");
    forgotPasswordModel.status = 0;
    forgotPasswordModel.message = "Time out";
    return forgotPasswordModel;
  } on SocketException catch (e) {
    debugPrint("SocketException in forgotPasswordService: $e");
    forgotPasswordModel.status = 0;
    forgotPasswordModel.message = "Internet connection failed";
    return forgotPasswordModel;
  } catch (e) {
    debugPrint("exception in forgotPasswordService: $e");
    forgotPasswordModel.status = 0;
    forgotPasswordModel.message = "Something went wrong";
    return forgotPasswordModel;
  }
}
