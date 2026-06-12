

import 'package:hive/hive.dart';
import 'package:news_reader_app/features/home/data/models/article_model.dart';
import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class BookMarkLocalDataSource {  

   Future<List<ArticleEntity>> getBookMarkedArticle();
   Future<void> removeArticle(String url);
     Future<void> saveArticle(ArticleEntity  articleModel);



}

class BookMarkLocalDataSourceImple implements BookMarkLocalDataSource {
  // final Dio dio;
  final Box<ArticleModel> _box;


  const BookMarkLocalDataSourceImple(this._box); 

  @override
  Future<List<ArticleEntity>> getBookMarkedArticle() async{
    return _box.values.map((model) => model.toEntity()).toList();

  }
  
  @override
  Future<void> removeArticle(String url) async{
    return _box.delete(url); 
  }

  @override
  Future<void> saveArticle(ArticleEntity  article) async{
    final model = ArticleModel.fromEntity(article);
    await _box.put(article.url, model);
  }


  
}