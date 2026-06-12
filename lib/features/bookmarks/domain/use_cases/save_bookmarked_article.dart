
import 'package:news_reader_app/features/bookmarks/domain/repository/book_mark_local_repo.dart';
import 'package:news_reader_app/features/home/data/models/article_model.dart';
import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';
import 'package:news_reader_app/features/home/domain/repositories/news_local_repository.dart';

class SaveArticleAtBokkMarked {
  final BookMarkLocalRepository repository;

  const SaveArticleAtBokkMarked(this.repository);

  Future<void> call({
   required ArticleEntity  articleEntity
  }) => repository.saveArticle(articleEntity);
}