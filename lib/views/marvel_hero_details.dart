import 'package:flutter/material.dart';
import 'package:desafio_marvel_objective/models/marvel_hero.dart';
import 'package:desafio_marvel_objective/repository/chatgptapi.dart';


class HeroDetails extends StatefulWidget {
  final MarvelHero hero;

  const HeroDetails({super.key, required this.hero});

  @override
  State<HeroDetails> createState() => _HeroDetailsState();
}

class _HeroDetailsState extends State<HeroDetails> {
  final double coverHeight = 220;
  final double profileHeight = 144;
  final estiloTextoDescricao =
      const TextStyle(color: Colors.black, fontSize: 16);
  final estiloTextoDescricaoTitulo =
      const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);

      //instanciando o ChatGptApiRepository com o nome do herói
  final chatGptApiRepository = ChatGptApiRepository();

  @override
  void initState() {
    super.initState();
    chatGptApiRepository.askAboutHero(widget.hero.name);
    chatGptApiRepository.askAboutHeroPTBR(widget.hero.name);
    chatGptApiRepository.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
        ],
      ),
    );
  }

  Stack buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          "images/marvel_banner.jpeg",
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        
        // pega a imagem do herói
        backgroundImage: NetworkImage(
          '${widget.hero.thumbnail}.${widget.hero.thumbnailExtension}',
        ),
      );

  Widget buildContent() => Column(
        children: [
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              // widget.hero.name,  
              widget.hero.name.isEmpty ? 'A Hero Without Name' : widget.hero.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.hero.description.isEmpty ? 'A Hero Without Description' : widget.hero.description,
              style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 4, 0, 255)),
            ),
          ),
          const SizedBox(height: 6),
          const SizedBox(height: 12),
          buildTopInformation(),
          const SizedBox(height: 18),
          
          const Divider(),
          const SizedBox(height: 12),
          buildHeroInformation(),
        ],
      );

  Widget buildOptionsButton(Icon icon, String texto, paginaDestino) =>
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => paginaDestino,
          ));
        },
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              child: Center(child: icon),
            ),
            const SizedBox(),
            Text(
              texto,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ],
        ),
      );

  Widget buildTopInformation() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildBox(text: 'Series', info: widget.hero.series.length.toString()),
          buildDivider(),
          buildBox(text: 'Comics', info: widget.hero.comics.length.toString()),
          buildDivider(),
          buildBox(text: 'Events', info: widget.hero.events.length.toString()),
          buildDivider(),
          buildBox(text: 'Stories', info: widget.hero.stories.length.toString()),
        ],
      );

  Widget buildBox({
    required String text,
    required String info,
  }) =>
      MaterialButton(
        onPressed: () {},
        padding: const EdgeInsets.symmetric(vertical: 4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              info,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
            const SizedBox(),
          ],
        ),
      );

  Widget buildDivider() => const SizedBox(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildHeroInformation() => Container(
    padding: const EdgeInsets.all(10),
    child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(
            'Usando o ChatGPT para gerar uma descrição do herói em Português:',
            style: estiloTextoDescricaoTitulo,
            softWrap: true,
          ),
          const SizedBox(height: 10),
          Text(
            chatGptApiRepository.messagePtBr,
            style: estiloTextoDescricao,
            softWrap: true,
          ),
          const SizedBox(height: 35),
          // crie uma divisão
          const Divider(),
          const SizedBox(height: 35),
          Text(
            'Using ChatGPT to generate a hero description in English:',
            style: estiloTextoDescricaoTitulo,
            softWrap: true,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            chatGptApiRepository.message,
            style: estiloTextoDescricao,
            softWrap: true,
          ),
        ],
      ),
  );
}
