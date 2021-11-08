import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialUsersScreen extends StatelessWidget {
  const SocialUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Users",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
      ),
    );
  }
}
