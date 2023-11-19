// To parse this JSON data, do
//
//     final referUserModel = referUserModelFromJson(jsonString);

import 'dart:convert';

ReferUserModel referUserModelFromJson(String str) => ReferUserModel.fromJson(json.decode(str));

String referUserModelToJson(ReferUserModel data) => json.encode(data.toJson());

class ReferUserModel {
    List<Datum>? data;
    String? message;
    int? status;

    ReferUserModel({
        this.data,
        this.message,
        this.status,
    });

    factory ReferUserModel.fromJson(Map<String, dynamic> json) => ReferUserModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "status": status,
    };
}

class Datum {
    int? id;
    String? userId;
    String? referredUserId;
    DateTime? createdAt;
    DateTime? updatedAt;
    ReferUser? referUser;

    Datum({
        this.id,
        this.userId,
        this.referredUserId,
        this.createdAt,
        this.updatedAt,
        this.referUser,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        referredUserId: json["referred_user_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        referUser: json["refer_user"] == null ? null : ReferUser.fromJson(json["refer_user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "referred_user_id": referredUserId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "refer_user": referUser?.toJson(),
    };
}

class ReferUser {
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

    ReferUser({
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

    factory ReferUser.fromJson(Map<String, dynamic> json) => ReferUser(
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
