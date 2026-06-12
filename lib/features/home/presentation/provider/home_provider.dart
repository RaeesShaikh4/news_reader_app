import 'package:flutter/material.dart';
import 'package:news_reader_app/core/utils/result.dart';
import 'package:news_reader_app/features/home/data/models/article_model.dart';
import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';
import 'package:news_reader_app/features/home/domain/use_cases/get_articles_list.dart'; 
import 'package:news_reader_app/features/home/domain/use_cases/save_bookmarked_article.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ArticleStatus { inital , loading, loaded, error}

class NewsProvider extends ChangeNotifier {
  final GetArticleListUseCase _getArticleUsecase;
  final SaveArticleAtBokkMarked _saveArticleBookmark; 

  

  NewsProvider({
    required GetArticleListUseCase getArticleUsecase,
    required SaveArticleAtBokkMarked saveArticleBookmar, 
    
  }) : _getArticleUsecase = getArticleUsecase, _saveArticleBookmark = saveArticleBookmar;

  List<ArticleEntity> _articles = []; 
  List<ArticleEntity> _bookMarkedArticles = []; 
  ArticleEntity? _selectedArticle;
  ArticleStatus _status = ArticleStatus.inital;
  String? _error;

  List<ArticleEntity> get articles => _articles;
  List<ArticleEntity> get bookMarkedArticles => _bookMarkedArticles;
  ArticleEntity? get selectedArticle => _selectedArticle;
  ArticleStatus get status => _status;
  String? get error => _error;
  bool get isLoading => _status == ArticleStatus.loading;


  Future<void> getTopHeadlines() async {
    _status = ArticleStatus.loading;
    _error = null;
    notifyListeners();

    final result = await _getArticleUsecase();
    switch(result) {
      case Success():
          _articles = result.data.articles;
          _status = ArticleStatus.loaded;
      case Failure():
           _error = result.exception.message;
           _status = ArticleStatus.error;
    }

  notifyListeners();

  }

Future<void> saveBookmark(ArticleEntity  article) async {
  await _saveArticleBookmark(articleEntity: article);
  // await getBookMarkedArticles();
  notifyListeners();
}



 

  
}