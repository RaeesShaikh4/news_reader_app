import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';

abstract interface class BookMarkLocalRepository {
  Future<List<ArticleEntity>> getBookMarkedArticle();
   Future<void> removeArticle(String url);
      Future<void> saveArticle(ArticleEntity  articleModel);

}