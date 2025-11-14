import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isUser ? const Color(0xFF00C48C) : Colors.white;
    final textColor = isUser ? Colors.white : const Color(0xFF1D2838);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Markdown(
          data: text,
          selectable: false,
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            p: TextStyle(color: textColor, fontSize: 15, height: 1.4),
            strong: TextStyle(
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            h1: TextStyle(color: textColor, fontSize: 22, fontWeight: FontWeight.bold),
            h2: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
            h3: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
            listBullet: TextStyle(color: textColor, fontSize: 15),
            code: TextStyle(
              backgroundColor: Colors.black12,
              color: textColor,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ),
    );
  }
}
