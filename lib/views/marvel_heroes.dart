import 'package:desafio_marvel_objective/models/marvel_series.dart';
import 'package:desafio_marvel_objective/models/marvel_events.dart';
import 'package:flutter/material.dart';
import 'package:desafio_marvel_objective/repository/marvel_heroes_repository.dart';
// import 'package:desafio_marvel_objective/components/search_text_field.dart';
import 'package:desafio_marvel_objective/views/marvel_hero_details.dart';

class MarvelHeroes extends StatefulWidget {
  const MarvelHeroes({super.key});

  @override
  _MarvelHeroesState createState() => _MarvelHeroesState();
}

class _MarvelHeroesState extends State<MarvelHeroes> {
  @override
  Widget build(BuildContext context) {
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
  const MarvelHeroesPage({super.key});

  @override
  State<MarvelHeroesPage> createState() => _MarvelHeroesPageState();
}

class _MarvelHeroesPageState extends State<MarvelHeroesPage> {
  late MarvelHeroesRepository marvelHeroesRepository;

  @override
  void initState() {
    super.initState();
    marvelHeroesRepository = MarvelHeroesRepository();
    marvelHeroesRepository.addListener(() {
      setState(() {});
    });
  }

  final int numberOfSeriesDisplayed = 3;
  final int numberOfEventsDisplayed = 3;

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

  final TextStyle _textStyleTableContent = const TextStyle(
      color: Color(0xFF4E4E4E),
      fontSize: 21,
      fontFamily: 'Roboto-Regular',
      letterSpacing: 0,
      height: 1.1);

  final double borderSideSize = 42;
  final double borderTopBottonSizePortrait = 12;
  final double borderTopBottonSizeLandscape = 34;

  int mouseOverIndex = -1;

  int lastPage = 0;

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

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 15,
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: mobileView
                      ? const EdgeInsets.fromLTRB(0, 12, 0, 24)
                      : EdgeInsets.fromLTRB(
                          borderSideSize, 20, borderSideSize, 16),
                  child: Column(
                    children: [
                      searchArea(
                          context, mobileView, boxWidth, mobileViewPortrait),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: !mobileView
                              ? const EdgeInsets.fromLTRB(0, 0, 0, 0)
                              : EdgeInsets.fromLTRB(
                                  borderSideSize, 0, borderSideSize, 0),
                          child: searchContainer(mobileViewPortrait)),
                      Column(
                        children: [
                          tableColmunsLabels(
                              mobileView,
                              context,
                              firstColumnWidth,
                              tableColumnTitleBoxHeight,
                              secondColumnWidth,
                              thirdColumnWidth),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 320,
                            child: ListView.builder(
                              itemCount: marvelHeroesRepository.heroes.length,
                              itemBuilder: (context, index) {
                                final displayedSeries = marvelHeroesRepository
                                    .heroes[index].series
                                    .take(numberOfSeriesDisplayed)
                                    .toList();
                                final displayedEvents = marvelHeroesRepository
                                    .heroes[index].events
                                    .take(numberOfEventsDisplayed)
                                    .toList();
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => HeroDetails(hero: marvelHeroesRepository.heroes[index]),
                                    ));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        color: mouseOverIndex == index
                                            ? Color(0xFFD42026).withOpacity(0.1)
                                            : Colors.white,
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 18, 0, 18),
                                        child: MouseRegion(
                                          onEnter: (_) {
                                            setState(() {
                                              mouseOverIndex = index;
                                            });
                                          },
                                          onExit: (_) {
                                            setState(() {
                                              mouseOverIndex = -1;
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              heroProfilePictureAndName(
                                                  mobileView,
                                                  context,
                                                  firstColumnWidth,
                                                  index),
                                              if (!mobileView)
                                                const SizedBox(
                                                  width: 10,
                                                  height: 50,
                                                ),
                                              if (!mobileView)
                                                heroSeriesList(secondColumnWidth,
                                                    displayedSeries),
                                              if (!mobileView)
                                                const SizedBox(
                                                  width: 10,
                                                  height: 50,
                                                ),
                                              if (!mobileView)
                                                heroEventsList(thirdColumnWidth,
                                                    displayedEvents),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 1,
                                        color: const Color(0xFFD42026),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back,
                      size: 16, color: Color(0xFFD42026)),
                  onPressed: () {
                    _setPage(marvelHeroesRepository.currentPage - 1);
                  },
                ),
                const SizedBox(width: 10),

                for (int i = (marvelHeroesRepository.currentPage < 3)
                        ? 1
                        : (marvelHeroesRepository.currentPage < 4)
                            ? 2
                            : (marvelHeroesRepository.currentPage < 5)
                                ? 3
                                : (marvelHeroesRepository.totalPages < 6)
                                    ? 1
                                    : marvelHeroesRepository.currentPage - 2;
                    i <=
                        ((marvelHeroesRepository.currentPage < 3)
                            ? 6
                            : (marvelHeroesRepository.currentPage < 4)
                                ? 7
                                : (marvelHeroesRepository.currentPage < 5)
                                    ? 8
                                    : (marvelHeroesRepository.totalPages < 6)
                                        ? marvelHeroesRepository.totalPages
                                        : marvelHeroesRepository.currentPage +
                                            3);
                    i++)
                  GestureDetector(
                    onTap: () {
                      marvelHeroesRepository.setPage(i - 1);
                    },
                    child: marvelHeroesRepository.totalPages >= i
                        ? Container(
                            width: 24,
                            height: 24,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: i - 1 == marvelHeroesRepository.currentPage
                                  ? const Color(0xFFD42026)
                                  : const Color(0xFF4E4E4E),
                            ),
                            child: Center(
                              child: Text(
                                '$i',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward,
                      size: 16, color: Color(0xFFD42026)),
                  onPressed: () {
                    _setPage(marvelHeroesRepository.currentPage + 1);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 12,
            color: const Color(0xFFD42026),
          )
        ],
      ),
    );
  }

  Row tableColmunsLabels(
      bool mobileView,
      BuildContext context,
      double firstColumnWidth,
      double tableColumnTitleBoxHeight,
      double secondColumnWidth,
      double thirdColumnWidth) {
    return Row(
      children: [
        Container(
          color: const Color(0xFFD42026),
          width:
              mobileView ? MediaQuery.of(context).size.width : firstColumnWidth,
          height: tableColumnTitleBoxHeight,
          padding: !mobileView
              ? const EdgeInsets.only(left: 12)
              : const EdgeInsets.only(left: 100),
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
            color: const Color(0xFFD42026),
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
            color: const Color(0xFFD42026),
            width: thirdColumnWidth,
            height: tableColumnTitleBoxHeight,
            padding: const EdgeInsets.only(left: 12),
            alignment: Alignment.centerLeft,
            child: Text('Eventos', style: _textStyleTableTitle),
          ),
      ],
    );
  }

  SizedBox heroSeriesList(
      double secondColumnWidth, List<MarvelSeries> displayedSeries) {
    return SizedBox(
      width: secondColumnWidth,
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: displayedSeries
                .map((series) => Text(
                      series.name,
                      style: _textStyleTableContent,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  SizedBox heroEventsList(
      double thirdColumnWidth, List<MarvelEvents> displayedEvents) {
    return SizedBox(
      width: thirdColumnWidth,
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: displayedEvents
                .map((events) => Text(
                      events.name,
                      style: _textStyleTableContent,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Container heroProfilePictureAndName(bool mobileView, BuildContext context,
      double firstColumnWidth, int index) {
    return Container(
      width: mobileView ? MediaQuery.of(context).size.width : firstColumnWidth,
      height: 80,
      padding: mobileView
          ? const EdgeInsets.only(left: 31)
          : const EdgeInsets.only(left: 12),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    '${marvelHeroesRepository.heroes[index].thumbnail}.${marvelHeroesRepository.heroes[index].thumbnailExtension}'),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Wrap(
            children: [
              SizedBox(
                width: firstColumnWidth - 80,
                child: Text(
                  marvelHeroesRepository.heroes[index].name,
                  style: _textStyleTableContent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container searchArea(BuildContext context, bool mobileView, double boxWidth,
      bool mobileViewPortrait) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: !mobileView
            ? const EdgeInsets.fromLTRB(0, 0, 0, 0)
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
            width:
                !mobileViewPortrait ? 400 : MediaQuery.of(context).size.width,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10),
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
                marvelHeroesRepository.searchName = value;
                marvelHeroesRepository.currentPage = 0;
                marvelHeroesRepository.searchHero(value);
              },
              style: const TextStyle(fontSize: 16),
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
