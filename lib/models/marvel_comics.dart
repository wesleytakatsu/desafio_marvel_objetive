class Marvelomics {
  final int id;
  final String name;
  final String resourceURI;
  
  Marvelomics({
    required this.id,
    required this.name,
    required this.resourceURI,
  });

  factory Marvelomics.fromJson(Map<String, dynamic> json) {
    return Marvelomics(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      resourceURI: json['resourceURI'] ?? '',
    );
  }
}