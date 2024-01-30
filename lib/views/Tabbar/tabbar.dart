import 'package:flutter/material.dart';
import 'package:mk_mining/views/auth/sign_in_scr.dart';
import 'package:mk_mining/views/auth/sign_up_scr.dart';

class TabbarWidget extends StatefulWidget {
  const TabbarWidget({super.key});

  @override
  State<TabbarWidget> createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.orange.shade50),
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.orange.shade100),
                child: TabBar(
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.amber.shade600),
                    controller: tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabAlignment: TabAlignment.start,
                    indicatorPadding: const EdgeInsets.all(2),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    isScrollable: true,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                    tabs: const [
                      Tab(
                        child: Text(
                          "SignIn",
                        ),
                      ),
                      Tab(
                        child: Text(
                          "SignUp",
                        ),
                      ),
                    ]),
              )
            ],
          ),
          Expanded(
              child: TabBarView(
                  controller: tabController,
                  children: const [SignInScreen(), SignUpScreen()]))
        ]),
      ),
    );
  }
}
