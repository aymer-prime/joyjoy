import 'package:flutter/material.dart';

class ChatIconInput extends StatelessWidget {
  final Function onpress;
  final String iconText;
  const ChatIconInput(
      {super.key, required this.onpress, required this.iconText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onpress(iconText);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          iconText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}
