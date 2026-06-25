import 'package:flutter/material.dart';
import 'package:news_reader_app/core/utils/result.dart';
import 'package:news_reader_app/features/bookmarks/domain/use_cases/get_bookmarks_use_case.dart';
import 'package:news_reader_app/features/bookmarks/domain/use_cases/remove_bookmark_use_case.dart';
import 'package:news_reader_app/features/home/data/models/article_model.dart';
import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';
import 'package:news_reader_app/features/home/domain/use_cases/get_articles_list.dart';
import 'package:news_reader_app/features/bookmarks/domain/use_cases/save_bookmarked_article.dart';
import 'package:news_reader_app/features/home/presentation/provider/home_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/scheduler.dart';

class BookMarkProvider extends ChangeNotifier {
  final GetBookmarkedArticles _getBookmarkedArticles;
  final RemaveBookmarkArticle _remaveBookmarkArticle;
  final SaveArticleAtBokkMarked _saveArticleBookmark;

  BookMarkProvider({
    required GetBookmarkedArticles getBookmarkArticles,
    required RemaveBookmarkArticle removeBookMarkedArticles,
    required SaveArticleAtBokkMarked saveArticleBookmar,
  })  : _getBookmarkedArticles = getBookmarkArticles,
        _remaveBookmarkArticle = removeBookMarkedArticles,
        _saveArticleBookmark = saveArticleBookmar;

  List<ArticleEntity> _articles = [];
  List<ArticleEntity> _bookMarkedArticles = [];
  final Set<String> _bookedMarksUrls = {};
  ArticleEntity? _selectedArticle;
  ArticleStatus _status = ArticleStatus.inital;
  String? _error;

  List<ArticleEntity> get articles => _articles;
  List<ArticleEntity> get bookMarkedArticles => _bookMarkedArticles;
  ArticleEntity? get selectedArticle => _selectedArticle;
  ArticleStatus get status => _status;
  String? get error => _error;
  bool get isLoading => _status == ArticleStatus.loading;
  Set<String> get bookedMarksUrl => _bookedMarksUrls;

  Future<void> getBookMarkedArticles() async {
    print('getBookMarkedArticles called----');
    _status = ArticleStatus.loading;
    notifyListeners();
    await SchedulerBinding.instance.endOfFrame;

    _bookMarkedArticles = await _getBookmarkedArticles();
    print('getBookMarkedArticles loaded----');

    _bookedMarksUrls.addAll(_bookMarkedArticles.map((e) => e.url));
    _status = ArticleStatus.loaded;
    print('getBookMarkedArticles end----');

    notifyListeners();
  }

  bool isBookMark(String url) {
    return _bookedMarksUrls.contains(url);
  }

  /// Call this when switching users to wipe previous user's in-memory state.
  void clearBookmarks() {
    _bookMarkedArticles = [];
    _bookedMarksUrls.clear();
    _status = ArticleStatus.inital;
    _error = null;
    notifyListeners();
  }

  Future<void> toggleBookMark(ArticleEntity article) async {
    if (_bookedMarksUrls.contains(article.url)) {
      await removeBookMark(article);
      _bookedMarksUrls.remove(article.url);
      _bookMarkedArticles.removeWhere((e) => e.url == article.url);
    } else {
      await saveBookmark(article);

      _bookedMarksUrls.add(article.url);
      _bookMarkedArticles.add(article);
    }
    notifyListeners();
  }

  Future<void> saveBookmark(ArticleEntity article) async {
    await _saveArticleBookmark(articleEntity: article);
    // await getBookMarkedArticles();
    notifyListeners();
  }

  Future<void> removeBookMark(ArticleEntity article) async {
    await _remaveBookmarkArticle(article.url);
    // await getBookMarkedArticles();
    notifyListeners();
  }
}
