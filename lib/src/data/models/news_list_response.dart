
import 'dart:convert';

class NewsListResponse {
  NewsListResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final int totalResults;
  final List<News> articles;

  factory NewsListResponse.fromRawJson(String str) => NewsListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsListResponse.fromJson(Map<String, dynamic> json) => NewsListResponse(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: List<News>.from(json["articles"].map((x) => News.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class News {
  News({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  factory News.fromRawJson(String str) => News.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory News.fromJson(Map<String, dynamic> json) => News(
    source: Source.fromJson(json["source"]),
    author: json["author"] ?? "",
    title: json["title"],
    description: json["description"] ?? "Description Not Available",
    url: json["url"] ?? "",
    urlToImage: json["urlToImage"] ?? "",
    publishedAt: DateTime.parse(json["publishedAt"]),
    content: json["content"] ?? "No More Details",
  );

  Map<String, dynamic> toJson() => {
    "source": source.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt.toIso8601String(),
    "content": content,
  };
}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Source.fromRawJson(String str) => Source.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
