class Article {
  final String title;
  final String description;
  final String urlToImage;
  final String content;
  final String url;
  bool isBookmarked;

  Article({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.content,
    required this.url,
    this.isBookmarked = false,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      content: json['content'] ?? '',
      url: json['url'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'content': content,
      'url': url,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Article && runtimeType == other.runtimeType && url == other.url;

  @override
  int get hashCode => url.hashCode;
}
