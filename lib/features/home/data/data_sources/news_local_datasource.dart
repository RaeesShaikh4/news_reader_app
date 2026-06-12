

import 'package:hive/hive.dart';
import 'package:news_reader_app/features/home/data/models/article_model.dart';
import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class NewsLocalDataSource {  

}

class NewsLocalDataSourceImple implements NewsLocalDataSource {
  // final Dio dio;
  final Box<ArticleModel> _box;


  const NewsLocalDataSourceImple(this._box); 


  
}