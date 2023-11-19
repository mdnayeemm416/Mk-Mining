//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
    Data? data;
    Balance? balance;
    String? message;
    int? status;

    SignUpModel({
        this.data,
        this.balance,
        this.message,
        this.status,
    });

    factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
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
    int? userId;
    int? mainBalance;
    int? miningBalance;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    Balance({
        this.userId,
        this.mainBalance,
        this.miningBalance,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        userId: json["user_id"],
        mainBalance: json["main_balance"],
        miningBalance: json["mining_balance"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "main_balance": mainBalance,
        "mining_balance": miningBalance,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}

class Data {
    String? name;
    dynamic phone;
    String? email;
    String? referCode;
    String? socialId;
    String? isActive;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    Data({
        this.name,
        this.phone,
        this.email,
        this.referCode,
        this.socialId,
        this.isActive,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        referCode: json["refer_code"],
        socialId: json["social_id"],
        isActive: json["is_active"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "refer_code": referCode,
        "social_id": socialId,
        "is_active": isActive,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
