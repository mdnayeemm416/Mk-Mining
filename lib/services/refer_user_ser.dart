import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mk_mining/configs/urls.dart';
import 'package:mk_mining/models/refer_user_mod.dart';

Future<ReferUserModel> referUserService({required String token}) async {
  debugPrint("call referUserService");
  final Uri url = Uri.parse(AppUrls.referUser);
  final ReferUserModel referUserModel = ReferUserModel();
  try {
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    if (response.statusCode == 200) {
      final referUserModel2 = referUserModelFromJson(response.body);
      final status = referUserModel2.status;
      if (status != null && status == 1) {
        debugPrint("status in referUserService: $status");
        return referUserModel2;
      } else {
        debugPrint("status in referUserService: $status");
        return referUserModel2;
      }
    } else {
      debugPrint(
          "response.statusCode in referUserService: ${response.statusCode}");
      referUserModel.status = 0;
      referUserModel.message = "Not found";
      referUserModel.data = null;
      return referUserModel;
    }
  } on TimeoutException catch (e) {
    debugPrint("TimeoutException in referUserService: $e");
    referUserModel.status = 0;
    referUserModel.message = "Time out";
    referUserModel.data = null;
    return referUserModel;
  } on SocketException catch (e) {
    debugPrint("SocketException in referUserService: $e");
    referUserModel.status = 0;
    referUserModel.message = "Internet connection failed";
    referUserModel.data = null;
    return referUserModel;
  } catch (e) {
    debugPrint("exception in referUserService: $e");
    referUserModel.status = 0;
    referUserModel.message = "Something went wrong";
    referUserModel.data = null;
    return referUserModel;
  }
}
