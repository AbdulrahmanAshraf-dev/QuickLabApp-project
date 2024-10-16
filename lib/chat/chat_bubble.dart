import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  final String message;

  final bool isCurrentUser;

  const ChatBubble(
      {required this.message, required this.isCurrentUser, super.key});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.isCurrentUser ? Colors.grey.shade500 : Colors.cyan),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Text(
        widget.message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
