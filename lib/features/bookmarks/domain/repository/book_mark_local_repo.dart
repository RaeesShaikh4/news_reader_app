import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';

abstract interface class BookMarkLocalRepository {
  Future<List<ArticleEntity>> getBookMarkedArticle();
}