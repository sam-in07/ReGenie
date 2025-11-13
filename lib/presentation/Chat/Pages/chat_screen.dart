import 'package:flutter/material.dart';
import 'package:regenie/presentation/widgets/primary_header.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> messages = [
      {
        'text':
        "Hi! I'm ReGenie, your AI eco companion. Ask me anything about living sustainably! 🌱",
        'isUser': false,
        'time': "10:25 PM",
      },
      {
        'text': "hi",
        'isUser': true,
        'time': "10:26 PM",
      },
      {
        'text':
        "I recommend composting food scraps! It reduces landfill waste and creates nutrient-rich soil for gardens. Win-win! 🌱",
        'isUser': false,
        'time': "10:26 PM",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: Column(
        children: [
          /// ✅ Green Rounded Header
          PrimaryHeader(
            height: 160,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center, // 👈 Keeps all aligned in a row
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ✅ Left side: back button + titles
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // ✅ Titles — perfectly centered with button
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center, // 👈 centers vertically
                        children: const [
                          Text(
                            "Ask ReGenie",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              height: 1, // tightens vertical spacing
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Your AI Eco Companion",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // ✅ Purple Star button
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF8A7CFD), Color(0xFF6D5BFF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(Icons.auto_awesome, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          /// ✅ Chat area
          Expanded(
            child: Container(
              color: const Color(0xFFF1FBF6), // light greenish background
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
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
                              ? const Color(0xFF00C48C) // 🌿 user bubble green
                              : Colors.white, // 🤖 AI bubble white
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
                            color: isUser
                                ? Colors.white
                                : const Color(0xFF1D2838),
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

        ],
      ),
    );
  }
}
