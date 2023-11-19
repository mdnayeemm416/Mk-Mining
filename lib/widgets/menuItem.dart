// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const MenuItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 98, 57, 4),
              Color.fromARGB(255, 135, 79, 7),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
