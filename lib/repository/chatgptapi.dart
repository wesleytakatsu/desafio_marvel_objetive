import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatGptApiRepository extends ChangeNotifier {
  String hero = '';
  String message = '';
  String messagePtBr = '';
  String apiUrl = dotenv.env['HERODETAILSEN']!;
  String apiUrlPt = dotenv.env['HERODETAILSPT']!;

  ChatGptApiRepository();

  askAboutHero(String hero) async {
    var response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({"heroName": hero}),
      headers: {
        "Content-Type": "application/json"
      }
    );

    if (response.statusCode == 200) {
      message = response.body;
    } else {
      print('Erro: ${response.statusCode}');
    }

    notifyListeners();
  }

  askAboutHeroPTBR(String hero) async {
    var response = await http.post(
      Uri.parse(apiUrlPt),
      body: jsonEncode({"heroName": hero}),
      headers: {
        "Content-Type": "application/json"
      }
    );

    if (response.statusCode == 200) {
      messagePtBr = response.body;
    } else {
      print('Erro: ${response.statusCode}');
    }

    notifyListeners();
  }

}
