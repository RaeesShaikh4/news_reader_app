import 'package:news_reader_app/core/exceptions/exceptions.dart';
import 'package:news_reader_app/core/utils/result.dart';
import 'package:news_reader_app/features/home/data/data_sources/news_remote_datasource.dart';
import 'package:news_reader_app/features/home/domain/entities/news_entity.dart';
import 'package:news_reader_app/features/home/domain/repositories/news_reposity.dart';

class NewsRepositorisImpl implements NewsRepository {
  final NewsRemoteDataSource dataSource;
  const NewsRepositorisImpl(this.dataSource);

  @override
  Future<Result<NewsEntity>> getTopHeadlines() async{
    try {
      final newsModel = await dataSource.getTopHeadlines();
      return Success(newsModel.toEntity());
      } on ApiException catch (e) {
        return Failure(e);
      }
  } 

}