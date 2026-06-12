import 'package:news_reader_app/features/home/domain/entities/source_entity.dart';

class ArticleEntity {
  final String? sourceId;
  final String sourceName;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  const ArticleEntity({
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
}