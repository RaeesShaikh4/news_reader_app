import 'package:news_reader_app/features/bookmarks/data/data_sources/bookmark_local_datasource.dart';
import 'package:news_reader_app/features/bookmarks/domain/repository/book_mark_local_repo.dart';
import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';

class BookMarkLocalRepositoryImpl implements BookMarkLocalRepository {
  final BookMarkLocalDataSource dataSource;
  const BookMarkLocalRepositoryImpl(this.dataSource);

  @override
  Future<List<ArticleEntity>> getBookMarkedArticle() {
    return dataSource.getBookMarkedArticle();

  }
}