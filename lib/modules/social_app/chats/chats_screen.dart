import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialChatsScreen extends StatelessWidget {
  const SocialChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Chats",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
      ),
    );
  }
}
