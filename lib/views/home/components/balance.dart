import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_mining/blocs/balance/balance_bloc.dart';
import 'package:mk_mining/configs/colors.dart';
import 'package:mk_mining/configs/sizes.dart';
import 'package:mk_mining/database/local_db.dart';
import 'package:mk_mining/widgets/app_alert_dialog.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Balance extends StatefulWidget {
  const Balance(
      {super.key,
      required this.mainBalance,
      required this.miningBalance,
      required this.token});
  final String mainBalance, miningBalance, token;

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  CountdownController countdownController =
      CountdownController(autoStart: false);

  bool mining = false;
  int secs = 86399;

  Future<bool> myTime() async {
    final tt = await LocalDB.fetchStartTime();
    if (tt == null) {
      debugPrint("tt: $tt");
      return true;
    }

    final isAddBalance = await LocalDB.fetchAddBalanceIs();
    if (isAddBalance == null) {
      debugPrint("isAddBalance: $isAddBalance");
      return true;
    }

    final dif = tt.difference(DateTime.now()).inSeconds;
    secs += dif;
    if (secs <= 0) {
      mining = false;
      secs = 86399;
      setState(() {});
      if (isAddBalance == 0) {
        return mining;
      } else {
        return true;
      }
    } else {
      mining = true;
      setState(() {});
      return mining;
    }
  }

//
  @override
  void initState() {
    myTime().then((value) {
      if (!value) {
        context.read<BalanceBloc>().add(FetchBalanceEvent(token: widget.token));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //for balance
        Row(
          children: [
            Container(
              height: 15,
              width: 3,
              decoration: const BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(AppSizes.radius))),
            ),
            const Text(
              " Balance",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(AppSizes.bodyPadding),
          margin: const EdgeInsets.only(top: AppSizes.radius),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(68.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: AppColors.grey.withOpacity(0.2),
                  offset: const Offset(1, 1),
                  blurRadius: 10.0),
            ],
          ),
          child: Row(
            children: [
              //balance status
              Expanded(
                  child: Column(
                children: [
                  //for main balance
                  Row(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * .1,
                        width: 2,
                        decoration: BoxDecoration(
                          color: AppColors.seed.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4, bottom: 2),
                              child: Text(
                                'Main',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  letterSpacing: -0.1,
                                  color: AppColors.grey.withOpacity(0.6),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: Image.asset("assets/images/coin.png"),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, bottom: 3),
                                  child: Text(
                                    widget.mainBalance,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: AppColors.darkerText,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, bottom: 3),
                                  child: Text(
                                    'Coins',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      letterSpacing: -0.2,
                                      color: AppColors.grey.withOpacity(0.6),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  //end main balance

                  //for mining balance
                  Row(
                    children: <Widget>[
                      Container(
                        height: 48,
                        width: 2,
                        decoration: BoxDecoration(
                          color: AppColors.nearlySeed.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4, bottom: 2),
                              child: Text(
                                'Mining',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  letterSpacing: -0.1,
                                  color: AppColors.grey.withOpacity(0.6),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(
                                  width: 28,
                                  height: 28,
                                  child:
                                      Image.asset("assets/images/mining.png"),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, bottom: 3),
                                  child: Text(
                                    widget.miningBalance,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: AppColors.darkerText,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, bottom: 3),
                                  child: Text(
                                    'Coins',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      letterSpacing: -0.2,
                                      color: AppColors.grey.withOpacity(0.6),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                  //end mining balance
                ],
              )),
              //balance status

              //count down
              Expanded(
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Countdown(
                          controller: countdownController,
                          seconds: secs,
                          build: (BuildContext context, double time) {
                            double normalizedValue = time / 86399; //1 day
                            final duration = Duration(seconds: time.toInt())
                                .toString()
                                .split(':');
                            final hour = duration[0];
                            final minute = duration[1];
                            return Stack(
                              children: [
                                //time count
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "$hour:$minute",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 24,
                                          letterSpacing: 0.0,
                                          color: AppColors.nearlySeed,
                                        ),
                                      ),
                                      Text(
                                        'Hrs left',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          letterSpacing: 0.0,
                                          color:
                                              AppColors.grey.withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //for indicator
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CircularProgressIndicator(
                                    value: normalizedValue,
                                    backgroundColor:
                                        AppColors.nearlySeed.withOpacity(0.3),
                                  ),
                                ),
                              ],
                            );
                          },
                          interval: const Duration(seconds: 1),
                          onFinished: () async {
                            debugPrint('Timer is done!');
                            secs = 86399;
                            mining = false;
                            context
                                .read<BalanceBloc>()
                                .add(FetchBalanceEvent(token: widget.token));

                            setState(() {});
                          },
                        ),
                      ),
                      mining
                          ? const SizedBox()
                          : InkWell(
                              onTap: () {
                                final requiredBalance =
                                    int.parse(widget.mainBalance);
                                if (requiredBalance < 1000) {
                                  appAlertDialog(
                                      context,
                                      "Insufficient Main Balance",
                                      "You can't start mining until your main balance is 1000 coins",
                                      actions: [
                                        CupertinoDialogAction(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "OK",
                                            style:
                                                TextStyle(color: AppColors.red),
                                          ),
                                        )
                                      ]);
                                  return;
                                }

                                appAlertDialog(context, "Are you sure?",
                                    "You want to start mining",
                                    actions: [
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Cancel",
                                          style:
                                              TextStyle(color: AppColors.red),
                                        ),
                                      ),
                                      CupertinoDialogAction(
                                        child: const Text("Sure"),
                                        onPressed: () async {
                                          secs = 86399;
                                          mining = true;
                                          countdownController.restart();
                                          setState(() {});
                                          await LocalDB.putStartTime(
                                                  startCounterTime:
                                                      DateTime.now())
                                              .then((value) {
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    ]);
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    gradient: const RadialGradient(colors: [
                                      AppColors.seed,
                                      AppColors.nearlySeed,
                                    ])),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 28,
                                      height: 28,
                                      child: Image.asset(
                                          "assets/images/mining.png"),
                                    ),
                                    const Text(
                                      "Start",
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
              //Count down
            ],
          ),
        ),
        //end balance
      ],
    );
  }
}
