import 'package:flutter/material.dart';

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
  int _counter = 0;

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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool mobileView = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: MediaQuery.of(context).size.width,
            padding: mobileView // 42 - 16 = 26 (espaçamento esperado)
                ? const EdgeInsets.fromLTRB(26, 12, 26, 12)
                : const EdgeInsets.fromLTRB(26, 20, 26, 34),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  //largura total da tela
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      // largura de 600px
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
                    Container(
                      // largura de 600px
                      width: 450,
                      child: Row(
                        // alinhar o texto a esquerda
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4, // Altura do retângulo
                            child: Container(
                              width: 54, // Largura do retângulo
                              color: Colors
                                  .red, // Cor do retângulo (altere conforme necessário)
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
        body: Center());

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Container(
    //       width: MediaQuery.of(context).size.width,
    //       // background na cor azul
    //       decoration: const BoxDecoration(
    //         color: Color.fromARGB(255, 32, 53, 212),
    //       ),
    //       padding: mobileView
    //           ? const EdgeInsets.fromLTRB(42, 12, 42, 12)
    //           : const EdgeInsets.fromLTRB(42, 20, 42, 34),
    //       child: Column(children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text.rich(
    //               TextSpan(
    //                 text: 'BUSCA MARVEL ',
    //                 style: _textStyleBlack,
    //                 children: <TextSpan>[
    //                   TextSpan(
    //                     text: 'TESTE FRONT-END',
    //                     style: _textStyleLight,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             if (mobileView) Text('WESLEY TAKATSU', style: _textStyleLight),
    //           ],
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 42),
    //           child: SizedBox(
    //             height: 4, // Altura do retângulo
    //             child: Container(
    //               width: 54, // Largura do retângulo
    //               color: Colors
    //                   .red, // Cor do retângulo (altere conforme necessário)
    //             ),
    //           ),
    //         ),
    //       ]),
    //     ),
    //   ),
    //   body: Center(),
    // );
  }
}
