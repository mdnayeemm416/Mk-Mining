import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mk_mining/configs/urls.dart';
import 'package:mk_mining/models/sign_in_mod.dart';

Future<SignInModel> signInService(
    {required Map<String, String> payload, required bool isGoogleSignIn}) async {
  debugPrint("call signInService");
  final Uri url = Uri.parse(isGoogleSignIn ? AppUrls.googleSignIn :AppUrls.signIn);
  final SignInModel signInModel = SignInModel();
  try {
    final response = await http.post(url, body: payload);
    if (response.statusCode == 200) {
      final signInModel2 = signInModelFromJson(response.body);
      final status = signInModel2.status;
      if (status != null && status == 1) {
        debugPrint("status in signInService: $status");
        return signInModel2;
      } else {
        debugPrint("status in signInService: $status");
        return signInModel2;
      }
    } else {
      debugPrint(
          "response.statusCode in signInService: ${response.statusCode}");
      signInModel.status = 0;
      signInModel.message = "Not found";
      return signInModel;
    }
  } on TimeoutException catch (e) {
        debugPrint("TimeoutException in signInService: $e");
        signInModel.status = 0;
      signInModel.message = "Time out";
      return signInModel;
      } on SocketException catch (e) {
        debugPrint("SocketException in signInService: $e");
        signInModel.status = 0;
      signInModel.message = "Internet connection failed";
      return signInModel;
      }
  catch (e) {
    debugPrint("exception in signInService: $e");
    signInModel.status = 0;
    signInModel.message = "Something went wrong";
    return signInModel;
  }
}
