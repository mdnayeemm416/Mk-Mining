import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mk_mining/configs/urls.dart';
import 'package:mk_mining/models/sign_up_mod.dart';


Future<SignUpModel> signUpService(
    {required Map<String, String> payload}) async {
  debugPrint("call signUpService");
  final Uri url = Uri.parse(AppUrls.signUp);
  final SignUpModel signUpModel = SignUpModel();
  try {
    final response = await http.post(url, body: payload);
    if (response.statusCode == 200) {
      final signInModel2 = signUpModelFromJson(response.body);
      final status = signInModel2.status;
      if (status != null && status == 1) {
        debugPrint("status in signUpService: $status");
        return signInModel2;
      } else {
        debugPrint("status in signUpService: $status");
        return signInModel2;
      }
    } else {
      debugPrint(
          "response.statusCode in signUpService: ${response.statusCode}");
      signUpModel.status = 0;
      signUpModel.message = "Not found";
      return signUpModel;
    }
  } on TimeoutException catch (e) {
        debugPrint("TimeoutException in signUpService: $e");
        signUpModel.status = 0;
      signUpModel.message = "Time out";
      return signUpModel;
      } on SocketException catch (e) {
        debugPrint("SocketException in signUpService: $e");
        signUpModel.status = 0;
      signUpModel.message = "Internet connection failed";
      return signUpModel;
      }
  catch (e) {
    debugPrint("exception in signUpService: $e");
    signUpModel.status = 0;
    signUpModel.message = "Something went wrong";
    return signUpModel;
  }
}
