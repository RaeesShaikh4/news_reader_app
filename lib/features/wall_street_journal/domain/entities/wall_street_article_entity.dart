import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';

class WallStreetArticleEntity extends ArticleEntity {
  // final String? sourceId;
  // final String sourceName;
  // final String? author;
  // final String title;
  // final String? description;
  // final String url;
  // final String? urlToImage;
  // final DateTime? publishedAt;
  // final String? content;

  const WallStreetArticleEntity({
    super.sourceId,
    required super.sourceName,
    super.author,
    required super.title,
    super.description,
    required super.url,
    super.urlToImage,
    super.publishedAt,
    super.content,
  });
}
