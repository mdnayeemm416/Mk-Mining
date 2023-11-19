import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class LocalDB {
  static const String loginBox = "loginBox";
  static const String timeBox = "timeBox";
  static const String addBalanceBox = "addBalanceBox";

  static const String loginIfo = "loginIfo";
  static const String startTime = "startTime";
  static const String addBalance = "addBalance";

  static Future<void> putLoginInfo({
    required String email,
    required String password,
    required String name,
    required String referCode,
    required String token,
    required String mainBalance,
    required String miningBalance,
    required String socialId,
    required String imgUrl,
  }) async {
    final box = await Hive.openBox(loginBox);
    box.put(loginIfo, [
      email, //0
      password, //1
      name, //2
      referCode, //3
      token, //4
      mainBalance, //5
      miningBalance, //6
      socialId, //7
      imgUrl //8
    ]);
  }

  static Future<List<String>?> fetchLoginInfo() async {
    final box = await Hive.openBox(loginBox);
    final info = box.get(loginIfo);
    return info;
  }

  static Future<void> deleteLoginInfo() async {
    final box = await Hive.openBox(loginBox);
    await box.clear();
    debugPrint("call deleteLoginInfo");
  }

  //for time
  static Future<void> putStartTime({required DateTime startCounterTime}) async {
    final box = await Hive.openBox(timeBox);

    try {
      box.put(startTime, startCounterTime);
      await putAddBalanceIs(isAddBalance: 0);
      debugPrint("startCounterTime: $startCounterTime");
    } catch (e) {
      debugPrint("error in putTime: $e");
    }
  }

  static Future<DateTime?> fetchStartTime() async {
    final box = await Hive.openBox(timeBox);

    final getTime = await box.get(startTime);
    return getTime;
  }

  static Future<void> deleteStartTime() async {
    final box = await Hive.openBox(timeBox);
    box.clear();
  }

  //for balance add or not
  static Future<void> putAddBalanceIs({required int isAddBalance}) async {
    final box = await Hive.openBox(addBalanceBox);

    try {
      box.put(addBalance, isAddBalance);
    } catch (e) {
      debugPrint("error in putAddBalanceIs: $e");
    }
  }

  static Future<int?> fetchAddBalanceIs() async {
    final box = await Hive.openBox(addBalanceBox);

    final isAddBalance = await box.get(addBalance);
    return isAddBalance;
  }
}
