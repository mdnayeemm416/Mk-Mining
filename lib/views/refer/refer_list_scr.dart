import 'package:flutter/material.dart';
import 'package:mk_mining/models/refer_user_mod.dart';
import 'package:mk_mining/views/refer/refer_list.dart';

class ReferListScreen extends StatelessWidget {
  const ReferListScreen({super.key, required this.referUserList});
  final List<ReferUser?> referUserList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Team"),
        centerTitle: false,
      ),
      body: ReferList(referUserList: referUserList,));
  }
}