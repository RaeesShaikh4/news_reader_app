import 'package:news_reader_app/core/exceptions/exceptions.dart';
import 'package:news_reader_app/core/utils/result.dart';
import 'package:news_reader_app/features/home/data/data_sources/news_local_datasource.dart';
import 'package:news_reader_app/features/home/data/data_sources/news_remote_datasource.dart';
import 'package:news_reader_app/features/home/data/models/article_model.dart';
import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';
import 'package:news_reader_app/features/home/domain/entities/news_entity.dart';
import 'package:news_reader_app/features/home/domain/repositories/news_local_repository.dart';
import 'package:news_reader_app/features/home/domain/repositories/news_reposity.dart';

class NewsLocalRepositorisImpl implements NewsLocalRepository {
  final NewsLocalDataSource dataSource;
  const NewsLocalRepositorisImpl(this.dataSource);
 
}