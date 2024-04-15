import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatGptApiRepository extends ChangeNotifier {
  String systemMessage = 'Tell me about this Marvel hero';
  String systemMessagePtBr = 'Me fale sobre este herói da Marvel';
  String hero = '';
  String message = '';
  String messagePtBr = '';
  String apiUrl = 'https://api.openai.com/v1/chat/completions';
  String apiKey = dotenv.env['OPENAIKEY']!;

  ChatGptApiRepository();

  askAboutHero(String hero) async {
    Map<String, dynamic> requestBody = {
      "model": "gpt-3.5-turbo-0125",
      "messages": [
        {"role": "system", "content": systemMessage},
        {"role": "user", "content": hero}
      ]
    };

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey"
    };


    var response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      message = responseData['choices'][0]['message']['content'];
    } else {
      print('Erro: ${response.statusCode}');
    }

    notifyListeners();
  }


  askAboutHeroPTBR(String hero) async {
    Map<String, dynamic> requestBody = {
      "model": "gpt-3.5-turbo-0125",
      "messages": [
        {"role": "system", "content": systemMessagePtBr},
        {"role": "user", "content": hero}
      ]
    };

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey"
    };

    var response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      messagePtBr = responseData['choices'][0]['message']['content'];
      messagePtBr = utf8.decode(messagePtBr.runes.toList());

    } else {
      print('Erro: ${response.statusCode}');
    }

    notifyListeners();
  }


}
