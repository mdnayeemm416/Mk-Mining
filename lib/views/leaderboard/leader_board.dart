import 'package:flutter/material.dart';
import 'package:mk_mining/configs/colors.dart';
import 'package:mk_mining/configs/sizes.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a list of names
    List<String> names = [
      "Md Nayeem",
      "Nishu Ahamed",
      "Md Sadek",
      "Md Tarik",
      "Md Kalam",
      "Md Taef",
      "Meherun Nesa",
      "Md Rafi",
      "Yeasin Hossain",
      "Taniya Akter"
      // Add more names as needed
    ];
    List<String> amount = [
      "12000",
      "11980",
      "10590",
      "10450",
      "10200",
      "9800",
      "8750",
      "7000",
      "6980",
      "6500"
      // Add more names as needed
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade300,
        title: const Row(
          children: [
            Icon(Icons.emoji_events_sharp,
                color: Color.fromARGB(255, 179, 127, 4)),
            SizedBox(width: 4), // Adjust the spacing as needed
            Text("Leaderboard"),
            SizedBox(width: 4),
            Icon(Icons.emoji_events_sharp,
                color: Color.fromARGB(255, 179, 127, 4)),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: const Text(
              "Top Earner .",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [Colors.amber, Colors.amber.shade200],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft)),
                    child: Center(
                      child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.bodyPadding),
                          leading: Container(
                            height: 48,
                            width: 48,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.seed,
                                    AppColors.nearlySeed
                                  ]),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  bottomLeft: Radius.circular(4.0),
                                  bottomRight: Radius.circular(4.0),
                                  topRight: Radius.circular(25.0)),
                            ),
                            child: Text(
                              (index + 1).toString(),
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white),
                            ),
                          ),
                          title: Text(
                            // Use the names list to display different texts
                            index < names.length ? names[index] : "",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: SizedBox(
                              width: 80,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/coin.png",
                                    height: 30,
                                  ),
                                  Text(
                                    // Use the names list to display different texts
                                    index < amount.length ? amount[index] : "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ))),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
