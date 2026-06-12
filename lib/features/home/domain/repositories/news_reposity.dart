import 'package:news_reader_app/core/utils/result.dart';
import 'package:news_reader_app/features/home/domain/entities/news_entity.dart';

abstract interface class NewsRepository {
  Future<Result<NewsEntity>> getTopHeadlines(); 
}