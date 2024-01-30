import 'package:flutter/material.dart';
import 'package:mk_mining/configs/sizes.dart';
import 'package:mk_mining/views/refer/refer_code.dart';

class InviteFriendWidget extends StatelessWidget {
  final String refercode;
  const InviteFriendWidget({super.key, required this.refercode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.width(context) * .030),
      child: Container(
        padding: const EdgeInsets.only(right: 20),
        height: 70,
        width: AppSizes.width(context),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(60),
                bottomRight: Radius.circular(10)),
            gradient: LinearGradient(
                colors: [Colors.amber.shade700, Colors.amber.shade800],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 80,
              color: Colors.amber.shade800,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset("assets/images/share.png"),
              ),
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Invite Friends",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
                Text("Share & Earn")
              ],
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReferCode(
                                referCode: refercode,
                              )));
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 30,
                ))
          ],
        ),
      ),
    );
  }
}
