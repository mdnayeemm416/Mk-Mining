// To parse this JSON data, do
//
//     final otpSendModel = otpSendModelFromJson(jsonString);

import 'dart:convert';

OtpSendModel otpSendModelFromJson(String str) => OtpSendModel.fromJson(json.decode(str));

String otpSendModelToJson(OtpSendModel data) => json.encode(data.toJson());

class OtpSendModel {
    Data? data;
    String? message;
    int? status;

    OtpSendModel({
        this.data,
        this.message,
        this.status,
    });

    factory OtpSendModel.fromJson(Map<String, dynamic> json) => OtpSendModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "status": status,
    };
}

class Data {
    String? email;
    int? code;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    Data({
        this.email,
        this.code,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        code: json["code"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "code": code,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
