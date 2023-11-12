import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
    this.msg, {
    super.key,
  });

  final Message msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding:
            const EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 32),
        decoration: BoxDecoration(
          color: kprimaryColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30)),
        ),
        child: Text(
          msg.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}


class ChatBubbleFromFriend extends StatelessWidget {
  const ChatBubbleFromFriend(
    this.msg, {
    super.key,
  });

  final Message msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding:
            const EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 32),
        decoration: BoxDecoration(
          color: ksecondryColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
        ),
        child: Text(
          msg.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
