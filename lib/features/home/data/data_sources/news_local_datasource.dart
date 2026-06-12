

import 'package:hive/hive.dart';
import 'package:news_reader_app/features/home/data/models/article_model.dart';
import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class NewsLocalDataSource {  

   Future<void> saveArticle(ArticleEntity  articleModel);
   Future<List<ArticleEntity>> getBookMarkedArticle();
   Future<void> removeArticle(String url);

}

class NewsLocalDataSourceImple implements NewsLocalDataSource {
  // final Dio dio;
  final Box<ArticleModel> _box;


  const NewsLocalDataSourceImple(this._box); 

@override
  Future<void> saveArticle(ArticleEntity  article) async{
    final model = ArticleModel.fromEntity(article);
    await _box.put(article.url, model);
  }

  @override
  Future<List<ArticleEntity>> getBookMarkedArticle() async{
    return _box.values.map((model) => model.toEntity()).toList();

  }

@override
Future<void> removeArticle(String url) async{
  return _box.delete(url);
}

  
}