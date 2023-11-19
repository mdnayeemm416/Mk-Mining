// To parse this JSON data, do
//
//     final forgotPasswordModel = forgotPasswordModelFromJson(jsonString);

import 'dart:convert';

ForgotPasswordModel forgotPasswordModelFromJson(String str) => ForgotPasswordModel.fromJson(json.decode(str));

String forgotPasswordModelToJson(ForgotPasswordModel data) => json.encode(data.toJson());

class ForgotPasswordModel {
    Data? data;
    String? message;
    int? status;

    ForgotPasswordModel({
        this.data,
        this.message,
        this.status,
    });

    factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) => ForgotPasswordModel(
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
    int? id;
    String? name;
    String? email;
    dynamic phone;
    dynamic emailVerifiedAt;
    String? socialId;
    String? referCode;
    String? isActive;
    DateTime? createdAt;
    DateTime? updatedAt;

    Data({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.emailVerifiedAt,
        this.socialId,
        this.referCode,
        this.isActive,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        emailVerifiedAt: json["email_verified_at"],
        socialId: json["social_id"],
        referCode: json["refer_code"],
        isActive: json["is_active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "email_verified_at": emailVerifiedAt,
        "social_id": socialId,
        "refer_code": referCode,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
