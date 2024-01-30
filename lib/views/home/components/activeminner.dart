import 'package:flutter/material.dart';
import 'package:mk_mining/configs/sizes.dart';

class ActiveMinnerWidget extends StatelessWidget {
  const ActiveMinnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.width(context) * .030),
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: AppSizes.width(context) * .066),
        height: 55,
        width: AppSizes.width(context),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 247, 145, 11),
              Color.fromARGB(255, 248, 146, 12),
            ], begin: Alignment.topCenter)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Active Minner",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 188, 101),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/images/miner.png"),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("2612")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
