import 'package:flutter/material.dart';

class MyWallet extends StatelessWidget {
  const MyWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade300,
        title: const Text("My Wallet"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset("assets/images/wallet.png"),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Expanded(
                child: Text(
              "My Wallet will be available when we reach to our mining goal. So keep patience and wait for a great move. Thanks",
              textAlign: TextAlign.center,
            )),
          )
        ],
      ),
    );
  }
}
