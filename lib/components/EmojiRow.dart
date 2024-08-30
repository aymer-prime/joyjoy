import 'package:flutter/material.dart';

import 'chat_icon_input.dart';

class EmojiRow extends StatelessWidget {
  final TextEditingController chatMessage;

  EmojiRow({required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    List<String> emojis = ["😂", "❤️", "😍", "😊", "😢", "😲", "👍🏼", "👏🏼", "🔥"];

    return Row(
      children: emojis.map((emoji) {
        return Expanded(
          child: ChatIconInput(
            onpress: (val) {
              chatMessage.text = chatMessage.text + val;
            },
            iconText: emoji,
          ),
        );
      }).toList(),
    );
  }
}
