// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
//
// class AIService {
//   static final _apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
//
//   static Future<String> sendMessage(String message) async {
//     final url = Uri.parse("https://api.openai.com/v1/chat/completions");
//
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $_apiKey',
//       },
//       body: jsonEncode({
//         "model": "gpt-4o-mini",
//         "messages": [
//           {
//             "role": "system",
//             "content":
//             "You are ReGenie, an eco-friendly AI assistant who gives advice about sustainable living."
//           },
//           {"role": "user", "content": message},
//         ],
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data["choices"][0]["message"]["content"];
//     }
//     else {
//       // print("❌ Error: ${response.body}");
//       print("❌ Status code: ${response.statusCode}");
//       print("❌ Body: ${response.body}");
//
//       return "⚠️ Sorry, I'm having trouble responding right now.";
//     }
//   }
// }

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
//
// class AIService {
//   static final _apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
//
//   static Future<String> sendMessage(String message) async {
//     final url = Uri.parse(
//       "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$_apiKey",
//     );
//
//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "contents": [
//           {
//             "parts": [
//               {"text": message}
//             ]
//           }
//         ]
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data["candidates"][0]["content"]["parts"][0]["text"];
//     } else {
//       print("❌ Gemini error: ${response.statusCode}");
//       print("❌ Body: ${response.body}");
//       return "⚠️ Sorry, I'm having trouble responding right now.";
//     }
//   }
// }
////////////////////////////////
import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  // ⚠️ NOTE: This key is HARDCODED and INSECURE for production apps.
  // For security, use a backend proxy server.
  static const String apiKey = "AIzaSyCMoVgK9Zvij_2-DD1WGiECAR2IOs1Fjno";

  // The apiUrl uses the apiKey for the query parameter
static const String apiUrl = 
"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-pro:generateContent?key=$apiKey";

  static Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": message}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Ensure you handle the possibility of a response with no text/candidates
      if (data["candidates"] != null && data["candidates"].isNotEmpty) {
        return data["candidates"][0]["content"]["parts"][0]["text"];
      }
      return "⚠️ Received an empty response from Gemini.";
    } else {
      print("❌ Gemini API Error: ${response.statusCode}");
      print("❌ Response Body: ${response.body}");
      return "⚠️ I'm having trouble responding right now. Please try again.";
    }
  }
}