import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mk_mining/configs/urls.dart';
import 'package:mk_mining/models/otp_send_mod.dart';


Future<OtpSendModel> otpSendService(
    {required Map<String, String> payload}) async {
  debugPrint("call otpSendService");
  final Uri url = Uri.parse(AppUrls.sendMail);
  final OtpSendModel otpSendModel = OtpSendModel();
  try {
    final response = await http.post(url, body: payload);
    if (response.statusCode == 200) {
      final otpSendModel2 = otpSendModelFromJson(response.body);
      final status = otpSendModel2.status;
      if (status != null && status == 1) {
        debugPrint("status in otpSendService: $status");
        return otpSendModel2;
      } else {
        debugPrint("status in otpSendService: $status");
        return otpSendModel2;
      }
    } else {
      debugPrint(
          "response.statusCode in otpSendService: ${response.statusCode}");
      otpSendModel.status = 0;
      otpSendModel.message = "Not found";
      return otpSendModel;
    }
  } on TimeoutException catch (e) {
        debugPrint("TimeoutException in otpSendService: $e");
        otpSendModel.status = 0;
      otpSendModel.message = "Time out";
      return otpSendModel;
      } on SocketException catch (e) {
        debugPrint("SocketException in otpSendService: $e");
        otpSendModel.status = 0;
      otpSendModel.message = "Internet connection failed";
      return otpSendModel;
      }
  catch (e) {
    debugPrint("exception in otpSendService: $e");
    otpSendModel.status = 0;
    otpSendModel.message = "Something went wrong";
    return otpSendModel;
  }
}