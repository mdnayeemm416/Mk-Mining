import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mk_mining/configs/colors.dart';
import 'package:mk_mining/configs/sizes.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart'; // Import the services library

class ReferCode extends StatelessWidget {
  const ReferCode({Key? key, required this.referCode}) : super(key: key);
  final String referCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Refer & Earn"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * .4,
            child: Image.asset("assets/images/referral.png"),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(AppSizes.bodyPadding * 1.5),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSizes.radius),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.hint.withOpacity(0.2),
                  blurRadius: 1.0,
                ),
              ],
            ),
            child: GestureDetector(
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: referCode));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Refer code copied to clipboard'),
                  ),
                );
              },
              child: Column(
                children: [
                  Text(
                    "Share your refer code with a friend and you both get coins\n",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grey.withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  DottedBorder(
                    color: AppColors.hint,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(AppSizes.radius / 2),
                    child: Row(
                      children: [
                        Text(
                          "   $referCode",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Share.share(referCode);
                          },
                          icon: const Icon(
                            Icons.share,
                            color: AppColors.seed,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
