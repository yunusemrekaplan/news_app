class News {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String source;

  News({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.source,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['name'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['image'],
      source: json['source'],
    );
  }
}
