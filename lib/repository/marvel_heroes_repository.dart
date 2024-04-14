import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:desafio_marvel_objective/models/marvel_hero.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class MarvelHeroesRepository extends ChangeNotifier {
  List<MarvelHero> heroes = [];
  // bool isSorted = false;
  int itensPerPage = 4;
  int currentPage = 0;

  MarvelHeroesRepository() {
    initRepository();
  }



  initRepository() async {
    await Future.delayed(Duration(seconds: 3)); //remover essa linha depois dos testes
    print("iniciando repository...");

    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String hash = md5.convert(utf8.encode(timestamp + dotenv.env['MARVELPRIVATEKEY']! + dotenv.env['MARVELPUBLICKEY']!)).toString();
    
    // print(hash);

    String url = '${dotenv.env['MARVELCHARACTERSURL']!.toString()}?ts=$timestamp&apikey=${dotenv.env['MARVELPUBLICKEY']!}&hash=${hash}&limit=$itensPerPage&offset=${(currentPage)*itensPerPage}';
    // print(url);

    final response = await http.get(
      Uri.parse(url)
    );

    final json = jsonDecode(response.body) as Map;

    // print(json['data']);

    List<dynamic> data = json['data']['results'];
    heroes = data.map((e) => MarvelHero.fromJson(e)).toList();
    // //print('response do GET:');
    // //print(json);
    print("Repository inicializado");
    // notifyListeners();
  }

}
