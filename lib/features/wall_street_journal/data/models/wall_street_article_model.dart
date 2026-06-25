import 'package:hive/hive.dart';
import 'package:news_reader_app/features/wall_street_journal/domain/entities/wall_street_article_entity.dart';

part 'wall_street_article_model.g.dart';

@HiveType(typeId: 1)
class WallStreetArticleModel {
  @HiveField(0)
  final String? sourceId;
  @HiveField(1)
  final String sourceName;
  @HiveField(2)
  final String? author;
  @HiveField(3)
  final String title;
  @HiveField(4)
  final String? description;
  @HiveField(5)
  final String url;
  @HiveField(6)
  final String? urlToImage;
  @HiveField(7)
  final DateTime? publishedAt;
  @HiveField(8)
  final String? content;

  const WallStreetArticleModel({
    this.sourceId,
    required this.sourceName,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory WallStreetArticleModel.fromJson(Map<String, dynamic> json) {
    final source = json['source'] as Map<String, dynamic>?;

    return WallStreetArticleModel(
      sourceId: source?['id'],
      sourceName: source?['name'] ?? '',
      author: json['author'],
      title: json['title'] ?? '',
      description: json['description'],
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : null,
      content: json['content'],
    );
  }

  factory WallStreetArticleModel.fromEntity(WallStreetArticleEntity entity) {
    return WallStreetArticleModel(
      sourceId: entity.sourceId,
      sourceName: entity.sourceName,
      author: entity.author,
      title: entity.title,
      description: entity.description,
      url: entity.url,
      urlToImage: entity.urlToImage,
      publishedAt: entity.publishedAt,
      content: entity.content,
    );
  }

  WallStreetArticleEntity toEntity() {
    return WallStreetArticleEntity(
      sourceId: sourceId,
      sourceName: sourceName,
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
  }
}
