// To parse this JSON data, do
//
//     final balanceModel = balanceModelFromJson(jsonString);

import 'dart:convert';

BalanceModel balanceModelFromJson(String str) => BalanceModel.fromJson(json.decode(str));

String balanceModelToJson(BalanceModel data) => json.encode(data.toJson());

class BalanceModel {
    Data? data;
    String? message;
    int? status;

    BalanceModel({
        this.data,
        this.message,
        this.status,
    });

    factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
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
    String? userId;
    String? mainBalance;
    int? miningBalance;
    DateTime? createdAt;
    DateTime? updatedAt;

    Data({
        this.id,
        this.userId,
        this.mainBalance,
        this.miningBalance,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
