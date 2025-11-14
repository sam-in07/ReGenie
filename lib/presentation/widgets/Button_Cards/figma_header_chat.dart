import 'package:flutter/material.dart';

Widget buildFigmaHeader(BuildContext context) {
  final w = MediaQuery.of(context).size.width;
  final isSmall = w < 360;

  return SafeArea(
    bottom: false,
    child: Container(
      width: double.infinity,
      height: isSmall ? 120 : 135,
      padding: EdgeInsets.only(
        top: 48,
        left: isSmall ? 16 : 24,
        right: isSmall ? 16 : 24,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF00BC7D),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(48),
          bottomRight: Radius.circular(48),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 6,
            offset: Offset(0, 4),
            spreadRadius: -4,
          ),
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 15,
            offset: Offset(0, 10),
            spreadRadius: -3,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: isSmall ? 36 : 40,
              height: isSmall ? 36 : 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: isSmall ? 18 : 20,
              ),
            ),
          ),

          SizedBox(width: isSmall ? 12 : 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ask ReGenie",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmall ? 20 : 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: isSmall ? 0 : 2),
                Text(
                  "Your AI Eco Companion",
                  style: TextStyle(
                    color: Color(0xFFD0FAE4),
                    fontSize: isSmall ? 13 : 15.2,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          // Container(
          //   width: isSmall ? 42 : 48,
          //   height: isSmall ? 42 : 48,
          //   decoration: BoxDecoration(
          //     gradient: const LinearGradient(
          //       colors: [Color(0xFFC17AFF), Color(0xFF50A2FF)],
          //     ),
          //     shape: BoxShape.circle,
          //   ),
          //   child: Center(
          //     child: Image.asset(
          //       "assets/images/chat_ai.png",
          //       width: isSmall ? 18 : 24,
          //       height: isSmall ? 18 : 24,
          //
          //     ),
          //   ),
          // ),
          Image.asset(
            "assets/images/chat_ai.png",
            width: 48,
            height: 48,
          )

        ],
      ),
    ),
  );
}
