import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';

class NewsEntity{
  final String status;
  final int totalResults;
  final List<ArticleEntity> articles;

  const NewsEntity({
    required this.status,
    required this.totalResults,
    required this.articles,
  });
}