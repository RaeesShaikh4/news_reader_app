import 'package:news_reader_app/core/utils/result.dart';
import 'package:news_reader_app/features/bookmarks/domain/repository/book_mark_local_repo.dart';
import 'package:news_reader_app/features/home/data/models/article_model.dart';
import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';
import 'package:news_reader_app/features/home/domain/entities/news_entity.dart';
import 'package:news_reader_app/features/home/domain/repositories/news_local_repository.dart';

class RemaveBookmarkArticle {
  final BookMarkLocalRepository repository;

  const RemaveBookmarkArticle(this.repository);

   Future<void> call(String url) => repository.removeArticle(url);
}