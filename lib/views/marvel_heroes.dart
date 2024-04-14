import 'package:flutter/material.dart';
import 'package:desafio_marvel_objective/repository/marvel_heroes_repository.dart';
import 'package:desafio_marvel_objective/components/search_text_field.dart';

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

  final TextStyle _textStyleBlackLandscape = const TextStyle(
    color: Color(0xFFD42026),
    fontSize: 27,
    fontFamily: 'Roboto-Black',
    letterSpacing: 0,
    height: 1.2,
    fontWeight: FontWeight.bold,
  );

  final TextStyle _textStyleBlackPortrait = const TextStyle(
    color: Color(0xFFD42026),
    fontSize: 16,
    fontFamily: 'Roboto-Black',
    letterSpacing: 0,
    height: 1.2,
    fontWeight: FontWeight.bold,
  );

  final TextStyle _textStyleLightLandscape = const TextStyle(
    color: Color(0xFFD42026),
    fontSize: 27,
    fontFamily: 'Roboto-Light',
    letterSpacing: 0,
    height: 1.2,
    fontWeight: FontWeight.normal,
  );

  final TextStyle _textStyleLightPortrait = const TextStyle(
    color: Color(0xFFD42026),
    fontSize: 16,
    fontFamily: 'Roboto-Light',
    letterSpacing: 0,
    height: 1.2,
    fontWeight: FontWeight.normal,
  );

  final TextStyle _textStyleTableTitle = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontSize: 16,
    fontFamily: 'Roboto-Regular',
    letterSpacing: 0,
    height: 1.2,
  );

  final double borderSideSize = 42;
  final double borderTopBottonSizePortrait = 12;
  final double borderTopBottonSizeLandscape = 34;

  void _setPage(int page) {
    setState(() {
      marvelHeroesRepository.currentPage = page;
      marvelHeroesRepository.initRepository();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool mobileView = MediaQuery.of(context).size.width <= 800;
    bool mobileViewPortrait = MediaQuery.of(context).size.width < 800;

    double boxWidth = mobileViewPortrait ? 300 : 480;

    double firstColumnWidth = mobileViewPortrait
        ? MediaQuery.of(context).size.width - (2 * borderSideSize)
        : ((MediaQuery.of(context).size.width - 2 * borderSideSize) * 0.25) -
            10;
    double secondColumnWidth =
        (MediaQuery.of(context).size.width - 2 * borderSideSize) * 0.25;
    double thirdColumnWidth =
        ((MediaQuery.of(context).size.width - 2 * borderSideSize) * 0.50) - 10;
    double tableColumnTitleBoxHeight = 37.0;

    print("largura da primeira coluna: $firstColumnWidth");
    print("largura da segunda coluna: $secondColumnWidth");
    print("largura da terceira coluna: $thirdColumnWidth");
    print("tamanho da tela: ${MediaQuery.of(context).size.width}");

    return Scaffold(
      appBar: AppBar(
        // menor tamanho da barra de título
        toolbarHeight: 15,
        // fonte pequena de 8, negrito
        title: const Text(
          'Desafio Objective em Flutter: Wesley Sieiro Takatsu de Araujo - (21) 99316-0875',
          style: TextStyle(
            color: Color(0xFFD42026),
            fontSize: 8,
            fontFamily: 'Roboto-Black',
            letterSpacing: 0,
            height: 1.2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          padding: mobileView
              ? EdgeInsets.fromLTRB(0, 12, 0, 24)
              : EdgeInsets.fromLTRB(borderSideSize, 20, borderSideSize, 16),
          child: Column(
            children: [
              searchArea(context, mobileView, boxWidth, mobileViewPortrait),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: !mobileView
                      ? EdgeInsets.fromLTRB(0, 0, 0, 0)
                      : EdgeInsets.fromLTRB(
                          borderSideSize, 0, borderSideSize, 0),
                  child: searchContainer(mobileViewPortrait)),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          color: Color(0xFFD42026),
                          width: mobileView
                              ? MediaQuery.of(context).size.width
                              : firstColumnWidth,
                          height: tableColumnTitleBoxHeight,
                          padding: !mobileView
                              ? EdgeInsets.only(left: 12)
                              : EdgeInsets.only(left: 100),
                          alignment: Alignment.centerLeft,
                          child: mobileView
                              ? Text('Nome', style: _textStyleTableTitle)
                              : Text('Personagem', style: _textStyleTableTitle),
                        ),
                        if (!mobileView)
                          SizedBox(
                            width: 10,
                            height: tableColumnTitleBoxHeight,
                          ),
                        if (!mobileView)
                          Container(
                            color: Color(0xFFD42026),
                            width: secondColumnWidth,
                            height: tableColumnTitleBoxHeight,
                            padding: const EdgeInsets.only(left: 12),
                            alignment: Alignment.centerLeft,
                            child: Text('Séries', style: _textStyleTableTitle),
                          ),
                        if (!mobileView)
                          SizedBox(
                            width: 10,
                            height: tableColumnTitleBoxHeight,
                          ),
                        if (!mobileView)
                          Container(
                            color: Color(0xFFD42026),
                            width: thirdColumnWidth,
                            height: tableColumnTitleBoxHeight,
                            padding: const EdgeInsets.only(left: 12),
                            alignment: Alignment.centerLeft,
                            child: Text('Eventos', style: _textStyleTableTitle),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Container searchArea(BuildContext context, bool mobileView, double boxWidth,
      bool mobileViewPortrait) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: !mobileView
            ? EdgeInsets.fromLTRB(0, 0, 0, 0)
            : EdgeInsets.fromLTRB(borderSideSize, 0, borderSideSize, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: boxWidth,
                  child: Text.rich(
                    TextSpan(
                      text: 'BUSCA MARVEL ',
                      style: mobileViewPortrait
                          ? _textStyleBlackPortrait
                          : _textStyleBlackLandscape,
                      children: <TextSpan>[
                        TextSpan(
                            text: 'TESTE FRONT-END',
                            style: mobileViewPortrait
                                ? _textStyleLightPortrait
                                : _textStyleLightLandscape),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: boxWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4,
                        child: Container(
                          width: 54,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (!mobileView)
            SizedBox(
              height: 40,
              child: Text('WESLEY TAKATSU', style: _textStyleLightLandscape),
            ),
          ],
        ));
  }

  Container searchContainer(bool mobileViewPortrait) {
    return Container(
      padding: EdgeInsets.only(
        top: mobileViewPortrait
            ? borderTopBottonSizePortrait
            : borderTopBottonSizeLandscape,
        bottom: mobileViewPortrait
            ? borderTopBottonSizePortrait
            : borderTopBottonSizeLandscape,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nome do Personagem',
            style: TextStyle(
              color: Color(0xFFD42026),
              fontSize: 16,
              fontFamily: 'Roboto-Light',
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 31,
            width: !mobileViewPortrait ? 400 : MediaQuery.of(context).size.width,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10), // Ajuste este valor para alterar a altura
                isCollapsed: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(
                    color: Color(0xFFD42026),
                    width: 1,
                  ),
                ),
              ),
              onChanged: (value) {
                print('Texto alterado: $value');
              },
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Row titleMarvel(double boxWidth, bool mobileViewPortrait, bool mobileView) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: boxWidth,
              child: Text.rich(
                TextSpan(
                  text: 'BUSCA MARVEL ',
                  style: mobileViewPortrait
                      ? _textStyleBlackPortrait
                      : _textStyleBlackLandscape,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'TESTE FRONT-END',
                        style: mobileViewPortrait
                            ? _textStyleLightPortrait
                            : _textStyleLightLandscape),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: boxWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4,
                    child: Container(
                      width: 54,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (mobileView) Text('WESLEY TAKATSU', style: _textStyleLightLandscape),
      ],
    );
  }
}
