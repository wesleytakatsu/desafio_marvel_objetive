import 'package:desafio_marvel_objective/models/marvel_series.dart';
import 'package:desafio_marvel_objective/models/marvel_events.dart';
import 'package:desafio_marvel_objective/models/marvel_comics.dart';
import 'package:desafio_marvel_objective/models/marvel_stories.dart';

class MarvelHero {
  final int id;
  final String name;
  final String description;
  final String thumbnail;
  final String thumbnailExtension;
  final List<MarvelSeries> series;
  final List<MarvelEvents> events;
  final List<Marvelomics> comics;
  final List<MarvelStories> stories;


  MarvelHero({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.thumbnailExtension,
    required this.series,
    required this.events,
    required this.comics,
    required this.stories,
  });

  factory MarvelHero.fromJson(Map<String, dynamic> json) {
    return MarvelHero(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail']['path'] ?? '',
      thumbnailExtension: json['thumbnail']['extension'] ?? '',
      series: (json['series']['items'] as List)
          .map((e) => MarvelSeries.fromJson(e))
          .toList(),
      events: (json['events']['items'] as List)
          .map((e) => MarvelEvents.fromJson(e))
          .toList(),
      comics: (json['comics']['items'] as List)
          .map((e) => Marvelomics.fromJson(e))
          .toList(),
      stories: (json['stories']['items'] as List)
          .map((e) => MarvelStories.fromJson(e))
          .toList(),
    );
  }
}