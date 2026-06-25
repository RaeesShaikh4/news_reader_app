import 'package:news_reader_app/features/wall_street_journal/domain/entities/wall_street_article_entity.dart';

class WallStreetNewsEntiry {
  final String status;
  final int totalResults;
  final List<WallStreetArticleEntity> articles;

  const WallStreetNewsEntiry({
    required this.status,
    required this.totalResults,
    required this.articles,
  });
}
