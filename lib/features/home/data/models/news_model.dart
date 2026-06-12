import 'package:news_reader_app/features/home/data/models/article_model.dart';
import 'package:news_reader_app/features/home/domain/entities/news_entity.dart';

class NewsModel{
 final String status;
 final int totalResults;
 final List<ArticleModel> articles;

 const NewsModel({
  required this.status,
  required this.totalResults,
  required this.articles
 }) ;

 factory NewsModel.fromJson(Map<String, dynamic> json){
  return NewsModel(
    status: json['status'],
    totalResults: json['totalResults'],
    articles: (json['articles'] as List<dynamic>)
          .map((article) => ArticleModel.fromJson(article))
          .toList(),
    );
 }

 NewsEntity toEntity() => NewsEntity(
  status: status,
  totalResults: totalResults,
  articles: articles.map((article) => article.toEntity()).toList()
 );
}