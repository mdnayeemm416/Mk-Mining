// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

SignInModel signInModelFromJson(String str) => SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
    Data? data;
    Balance? balance;
    String? message;
    int? status;

    SignInModel({
        this.data,
        this.balance,
        this.message,
        this.status,
    });

    factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        balance: json["balance"] == null ? null : Balance.fromJson(json["balance"]),
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "balance": balance?.toJson(),
        "message": message,
        "status": status,
    };
}

class Balance {
    int? id;
    String? userId;
    String? mainBalance;
    String? miningBalance;
    DateTime? createdAt;
    DateTime? updatedAt;

    Balance({
        this.id,
        this.userId,
        this.mainBalance,
        this.miningBalance,
        this.createdAt,
        this.updatedAt,
    });

    factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        id: json["id"],
        userId: json["user_id"],
        mainBalance: json["main_balance"],
        miningBalance: json["mining_balance"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "main_balance": mainBalance,
        "mining_balance": miningBalance,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Data {
    String? token;
    User? user;

    Data({
        this.token,
        this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user?.toJson(),
    };
}

class User {
    int? id;
    String? name;
    String? email;
    String? phone;
    dynamic emailVerifiedAt;
    String? socialId;
    String? referCode;
    String? isActive;
    DateTime? createdAt;
    DateTime? updatedAt;

    User({
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

    factory User.fromJson(Map<String, dynamic> json) => User(
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
