import 'package:news_reader_app/core/utils/result.dart';
import 'package:news_reader_app/features/home/domain/entities/news_entity.dart';
import 'package:news_reader_app/features/home/domain/repositories/news_reposity.dart';

class GetArticleListUseCase {
  final NewsRepository repository;

  const GetArticleListUseCase(this.repository);

  Future<Result<NewsEntity>> call() => repository.getTopHeadlines();
}