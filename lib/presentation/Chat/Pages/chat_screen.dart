import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:regenie/core/firebase/ai_service.dart';
import 'package:regenie/presentation/widgets/Button_Cards/figma_header_chat.dart';

import 'package:regenie/presentation/widgets/primary_header.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _messages = [
    {
      'text': "Hi! I'm ReGenie, your AI eco companion. Ask me anything about living sustainably! 🌱",
      'isUser': false,
      'time': DateFormat('hh:mm a').format(DateTime.now()),
    },
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  void _sendMessage() async {
    final userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({
        'text': userMessage,
        'isUser': true,
        'time': DateFormat('hh:mm a').format(DateTime.now()),
      });
      _isLoading = true;
      _controller.clear();
    });

    _scrollToBottom();

    // 🧠 Send to AI
    final reply = await AIService.sendMessage(userMessage);

    setState(() {
      _messages.add({
        'text': reply,
        'isUser': false,
        'time': DateFormat('hh:mm a').format(DateTime.now()),
      });
      _isLoading = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          /// ✅ Green header
          buildFigmaHeader(context),

          /// ✅ Chat area
          Expanded(
            child: Container(
              color: const Color(0xFFF1FBF6),
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_isLoading && index == _messages.length) {
                    return const Padding(
                      padding: EdgeInsets.all(8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("ReGenie is typing... 🌱",
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                      ),
                    );
                  }

                  final message = _messages[index];
                  final isUser = message['isUser'] as bool;

                  return Column(
                    crossAxisAlignment:
                    isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(14),
                        constraints: const BoxConstraints(maxWidth: 280),
                        decoration: BoxDecoration(
                          color: isUser
                              ? const Color(0xFF00C48C)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                              spreadRadius: -2,
                            ),
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 6,
                              offset: Offset(0, 4),
                              spreadRadius: -1,
                            ),
                          ],
                        ),
                        child: Text(
                          message['text'],
                          style: TextStyle(
                            color:
                            isUser ? Colors.white : const Color(0xFF1D2838),
                            fontSize: 15.2,
                            height: 1.6,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: isUser ? 0 : 8,
                            right: isUser ? 8 : 0,
                            bottom: 4),
                        child: Text(
                          message['time'],
                          style: const TextStyle(
                            color: Color(0xFF697282),
                            fontSize: 13,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          /// ✅ Input bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask about eco-friendly tips...",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF00C48C),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}