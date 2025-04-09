import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:voicegpt/app/constants/app.keys.dart';
import 'package:voicegpt/app/routes/api.routes.dart';

class OpenAI {
  final client = http.Client();
  static const apiKey = AppKeys.apiKey;
  final url = Uri.https("xhang.buaa.edu.cn", "/xhang/v1/chat/completions");

  Future<dynamic> generateText(String prompt) async {
    final client = http.Client(); // 每次请求创建新的客户端
    try {
      final response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey",
        },
        body: jsonEncode({
          "model": "xhang",
          "messages": [
            {
              "role": "user",
              "content": prompt,
            }
          ],
          "temperature": 0,
          "max_tokens": 2000,
          "top_p": 1,
          "frequency_penalty": 0.0,
          "presence_penalty": 0.0,
        }),
      );

      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        print("Decoded Response: $decodedBody");
        return jsonDecode(decodedBody);
      } else {
        print("Error: ${response.statusCode}, ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception occurred: $e");
      return null;
    } finally {
      client.close(); // 确保客户端在使用后关闭
    }
  }
}
