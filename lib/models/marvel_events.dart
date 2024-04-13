class MarvelEvents {
  final String id;
  final String name;
  final String resourceURI;
  
  MarvelEvents({
    required this.id,
    required this.name,
    required this.resourceURI,
  });

  factory MarvelEvents.fromJson(Map<String, dynamic> json) {
    return MarvelEvents(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      resourceURI: json['resourceURI'] ?? '',
    );
  }
}