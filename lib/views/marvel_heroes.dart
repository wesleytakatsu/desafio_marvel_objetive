import 'package:flutter/material.dart';
import 'package:desafio_marvel_objective/repository/marvel_heroes_repository.dart';

class MarvelHeroes extends StatefulWidget {
  const MarvelHeroes({Key? key}) : super(key: key);

  @override
  _MarvelHeroesState createState() => _MarvelHeroesState();
}

class _MarvelHeroesState extends State<MarvelHeroes> {
  @override
  Widget build(BuildContext context) {
    // COLOQUE "BUSCA MARVEL" EM NEGRITO E "TESTE FRONT-END" NORMAL Na esquerda e "WESLEY TAKATSU" na direita
    return MaterialApp(
      title: 'MARVEL HEROES',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MarvelHeroesPage(),
    );
  }
}

class MarvelHeroesPage extends StatefulWidget {
  const MarvelHeroesPage({Key? key}) : super(key: key);

  // final String title;

  @override
  State<MarvelHeroesPage> createState() => _MarvelHeroesPageState();
}

class _MarvelHeroesPageState extends State<MarvelHeroesPage> {
  late MarvelHeroesRepository marvelHeroesRepository;

  @override
  void initState() {
    super.initState();
    marvelHeroesRepository = MarvelHeroesRepository();
  }

  final TextStyle _textStyleBlack = const TextStyle(
    color: Color(0xFFD42026),
    fontSize: 27,
    fontFamily: 'Roboto-Black',
    letterSpacing: 0,
    height: 1.2,
    fontWeight: FontWeight.bold,
  );

  final TextStyle _textStyleLight = const TextStyle(
    color: Color(0xFFD42026),
    fontSize: 27,
    fontFamily: 'Roboto-Light',
    letterSpacing: 0,
    height: 1.2,
    fontWeight: FontWeight.normal,
  );

  final double borderSideSize = 42 - 16;

  void _setPage(int page) {
    setState(() {
      marvelHeroesRepository.currentPage = page;
      marvelHeroesRepository.initRepository();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool mobileView = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: MediaQuery.of(context).size.width,
            padding: mobileView
                ? EdgeInsets.fromLTRB(borderSideSize, 12, borderSideSize, 12)
                : EdgeInsets.fromLTRB(borderSideSize, 20, borderSideSize, 34),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 450,
                      child: Text.rich(
                        TextSpan(
                          text: 'BUSCA MARVEL ',
                          style: _textStyleBlack,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'TESTE FRONT-END',
                              style: _textStyleLight,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 450,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4,
                            child: Container(
                              width: 54,
                              color: Colors
                                  .red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (mobileView) Text('WESLEY TAKATSU', style: _textStyleLight),
              ],
            ),
          ),
        ),
        body: const Center());

  }
}
