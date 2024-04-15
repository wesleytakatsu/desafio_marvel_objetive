class MarvelStories {
  final int id;
  final String name;
  final String resourceURI;
  final String type;
  
  MarvelStories({
    required this.id,
    required this.name,
    required this.resourceURI,
    required this.type,
  });

  factory MarvelStories.fromJson(Map<String, dynamic> json) {
    return MarvelStories(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      resourceURI: json['resourceURI'] ?? '',
      type: json['type'] ?? '',
    );
  }
}