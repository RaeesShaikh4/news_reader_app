import 'package:flutter/material.dart';
import 'package:news_reader_app/core/utils/result.dart';
import 'package:news_reader_app/features/bookmarks/domain/use_cases/get_bookmarks_use_case.dart';
import 'package:news_reader_app/features/home/data/models/article_model.dart';
import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';
import 'package:news_reader_app/features/home/domain/use_cases/get_articles_list.dart'; 
import 'package:news_reader_app/features/home/domain/use_cases/save_bookmarked_article.dart';
import 'package:news_reader_app/features/home/presentation/provider/home_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/scheduler.dart';


class BookMarkProvider extends ChangeNotifier { 
  final GetBookmarkedArticles _getBookmarkedArticles;

  BookMarkProvider({ 
    required GetBookmarkedArticles getBookmarkArticles,
    
  }) :  _getBookmarkedArticles = getBookmarkArticles;

  List<ArticleEntity> _articles = []; 
  List<ArticleEntity> _bookMarkedArticles = []; 
  final Set<String> _bookedMarks = {};
  ArticleEntity? _selectedArticle;
  ArticleStatus _status = ArticleStatus.inital;
  String? _error;

  List<ArticleEntity> get articles => _articles;
  List<ArticleEntity> get bookMarkedArticles => _bookMarkedArticles;
  ArticleEntity? get selectedArticle => _selectedArticle;
  ArticleStatus get status => _status;
  String? get error => _error;
  bool get isLoading => _status == ArticleStatus.loading;


 Future<void> getBookMarkedArticles() async {
  print('getBookMarkedArticles called----');
    _status = ArticleStatus.loading; 
    notifyListeners(); 
    await SchedulerBinding.instance.endOfFrame;
  
    _bookMarkedArticles = await _getBookmarkedArticles();
    _status = ArticleStatus.loaded;
  notifyListeners();
  }


 

  
}