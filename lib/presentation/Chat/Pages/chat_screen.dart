import 'package:flutter/material.dart';
import 'package:regenie/presentation/widgets/primary_header.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text(
                              "Hi! I'm ReGenie, your AI eco companion. "
                                  "Ask me anything about living sustainably! 🌱",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "05:59 PM",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ✅ Input field with working send button
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
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

                        /// ✅ Send icon works as a button
                        GestureDetector(
                          onTap: () {
                            // 👉 Do your send action here
                            debugPrint("Message sent!");
                          },
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
            ),
          ),
        ],
      ),
    );
  }
}
