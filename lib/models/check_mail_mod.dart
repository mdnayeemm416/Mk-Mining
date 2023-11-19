// To parse this JSON data, do
//
//     final checkMailModel = checkMailModelFromJson(jsonString);

import 'dart:convert';

CheckMailModel checkMailModelFromJson(String str) => CheckMailModel.fromJson(json.decode(str));

String checkMailModelToJson(CheckMailModel data) => json.encode(data.toJson());

class CheckMailModel {
    String? message;
    int? status;

    CheckMailModel({
        this.message,
        this.status,
    });

    factory CheckMailModel.fromJson(Map<String, dynamic> json) => CheckMailModel(
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
    };
}
