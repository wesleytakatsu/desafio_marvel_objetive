import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:desafio_marvel_objective/models/marvel_hero.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MarvelHeroesRepository extends ChangeNotifier {
  List<MarvelHero> heroes = [];
  bool isSorted = false;

  MarvelHeroesRepository() {
    initRepository();
  }

  sort (){
    if(!isSorted){
      heroes.sort((MarvelHero a, MarvelHero b) => a.name.compareTo(b.name));
      isSorted = true;
    } else {
      heroes = heroes.reversed.toList();
    }
    notifyListeners();
  }

  initRepository() async {
    final response = await http.get(
      Uri.parse('http://oscrafitadores.ddns.net:3200/')
    );

    final json = jsonDecode(response.body) as Map;

    List<dynamic> data = json['data'];
    heroes = data.map((e) => MarvelHero.fromJson(e)).toList();
    //print('response do GET:');
    //print(json);

    notifyListeners();
  }

}
