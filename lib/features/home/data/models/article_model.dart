import 'package:hive/hive.dart';
import 'package:news_reader_app/features/home/data/models/source_model.dart';
import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';

part 'article_model.g.dart';

@HiveType(typeId: 0)
class ArticleModel {
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

  const ArticleModel({
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

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final source = json['source'] as Map<String, dynamic>?;

    return ArticleModel(
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

  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
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

  ArticleEntity toEntity() {
    return ArticleEntity(
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