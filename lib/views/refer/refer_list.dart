import 'package:flutter/material.dart';
import 'package:mk_mining/configs/colors.dart';
import 'package:mk_mining/configs/sizes.dart';
import 'package:mk_mining/models/refer_user_mod.dart';

class ReferList extends StatelessWidget {
  const ReferList({super.key, required this.referUserList, this.count});
  final List<ReferUser?> referUserList;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: count == null
            ? referUserList.length
            : referUserList.length < (count ?? 10)
                ? referUserList.length
                : count,
        itemBuilder: (_, i) {
          final data = referUserList[i];
          if (data == null) {
            return const SizedBox();
          } else {
            return ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.bodyPadding),
              leading: Container(
                height: 48,
                width: 48,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.seed, AppColors.nearlySeed]),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      bottomLeft: Radius.circular(4.0),
                      bottomRight: Radius.circular(4.0),
                      topRight: Radius.circular(25.0)),
                ),
                child: Text(
                  data.name == null
                      ? "null"
                      : data.name!.characters.first.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
              ),
              title: Text(
                data.name ?? 'null',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
        });
  }
}
