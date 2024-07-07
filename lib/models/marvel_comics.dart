class MarvelComics {
  final int id;
  final String name;
  final String resourceURI;
  
  MarvelComics({
    required this.id,
    required this.name,
    required this.resourceURI,
  });

  factory MarvelComics.fromJson(Map<String, dynamic> json) {
    return MarvelComics(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      resourceURI: json['resourceURI'] ?? '',
    );
  }
}