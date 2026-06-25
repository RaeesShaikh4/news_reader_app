import 'package:news_reader_app/features/home/data/models/article_model.dart';
import 'package:news_reader_app/features/wall_street_journal/data/models/wall_street_article_model.dart';
import 'package:news_reader_app/features/wall_street_journal/domain/entities/wall_street_news_entiry.dart';

class WallStreetNewsModel {
  final String status;
  final int totalResults;
  final List<WallStreetArticleModel> articles;

  const WallStreetNewsModel(
      {required this.status,
      required this.totalResults,
      required this.articles});

  factory WallStreetNewsModel.fromJson(Map<String, dynamic> json) {
    return WallStreetNewsModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: (json['articles'] as List<dynamic>)
          .map((article) => WallStreetArticleModel.fromJson(article))
          .toList(),
    );
  }

  WallStreetNewsEntiry toEntity() => WallStreetNewsEntiry(
      status: status,
      totalResults: totalResults,
      articles: articles.map((article) => article.toEntity()).toList());
}
