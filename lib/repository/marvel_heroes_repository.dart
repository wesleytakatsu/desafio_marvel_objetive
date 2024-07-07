import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:desafio_marvel_objective/models/marvel_hero.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class MarvelHeroesRepository extends ChangeNotifier {
  List<MarvelHero> heroes = [];
  int itensPerPage = int.parse(dotenv.env['HEROESPERPAGE']!);
  int currentPage = 0;
  int totalResults = 0;
  String searchName = '';
  int totalPages = 0;

  MarvelHeroesRepository() {
    initRepository();
  }



  initRepository() async {
    await Future.delayed(const Duration(seconds: 3)); //remover essa linha depois dos testes
    print("iniciando repository...");

    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String hash = md5.convert(utf8.encode(timestamp + dotenv.env['MARVELPRIVATEKEY']! + dotenv.env['MARVELPUBLICKEY']!)).toString();
    

    String url = '${dotenv.env['MARVELCHARACTERSURL']!.toString()}?ts=$timestamp&apikey=${dotenv.env['MARVELPUBLICKEY']!}&hash=$hash&limit=$itensPerPage&offset=${(currentPage)*itensPerPage}';

    final response = await http.get(
      Uri.parse(url)
    );

    final json = jsonDecode(response.body) as Map;

    totalResults = json['data']['total'];
    // print('totalResults: $totalResults');

    totalPages = (totalResults / itensPerPage).ceil();

    List<dynamic> data = json['data']['results'];
    heroes = data.map((e) => MarvelHero.fromJson(e)).toList();

    print("Repository inicializado");
    notifyListeners();
  }


  searchHero(String name) async {
    if(name.isEmpty) {
      return;
    }
    // print("iniciando a busca...");

    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String hash = md5.convert(utf8.encode(timestamp + dotenv.env['MARVELPRIVATEKEY']! + dotenv.env['MARVELPUBLICKEY']!)).toString();
    

    String url = '${dotenv.env['MARVELCHARACTERSURL']!.toString()}?ts=$timestamp&apikey=${dotenv.env['MARVELPUBLICKEY']!}&hash=$hash&limit=$itensPerPage&offset=${(currentPage)*itensPerPage}&nameStartsWith=$name';

    final response = await http.get(
      Uri.parse(url)
    );

    final json = jsonDecode(response.body) as Map;

    totalResults = json['data']['total'];
    // print('totalResults: $totalResults');

    totalPages = (totalResults / itensPerPage).ceil();

    List<dynamic> data = json['data']['results'];
    heroes = data.map((e) => MarvelHero.fromJson(e)).toList();

    // print("Busca finalizada");
    notifyListeners();
  }

  setPage(int page) {
    currentPage = page;
    print("currentPage: $currentPage");

    if(searchName.isNotEmpty) {
      searchHero(searchName);
    } else {
      initRepository();
    }
    notifyListeners();
  }

}
