import 'package:flutter/material.dart';
import 'package:news_reader_app/core/utils/result.dart';
import 'package:news_reader_app/features/wall_street_journal/domain/entities/wall_street_article_entity.dart';
import 'package:news_reader_app/features/wall_street_journal/domain/use_case/get_wall_street_journal_use_case.dart';

enum WallStreetArtivcleStatus { inital, loading, loaded, error }

class WallStreetProvider extends ChangeNotifier {
  final GetWallStreetJournalUseCase _getWallStreetJournalUseCase;

  WallStreetProvider({
    required GetWallStreetJournalUseCase getWallStreetJournalUseCase,
  }) : _getWallStreetJournalUseCase = getWallStreetJournalUseCase;

  List<WallStreetArticleEntity> _articles = [];
  WallStreetArtivcleStatus _status = WallStreetArtivcleStatus.inital;
  String? _error;

  List<WallStreetArticleEntity> get articles => _articles;
  WallStreetArtivcleStatus get status => _status;
  String? get error => _error;
  bool get isLoading => _status == WallStreetArtivcleStatus.loading;

  Future<void> getWallStreetJournal() async {
    _status = WallStreetArtivcleStatus.loading;
    _error = null;
    notifyListeners();

    final result = await _getWallStreetJournalUseCase();
    switch (result) {
      case Success():
        _articles = result.data.articles;
        _status = WallStreetArtivcleStatus.loaded;
      case Failure():
        _error = result.exception.message;
        _status = WallStreetArtivcleStatus.error;
    }

    notifyListeners();
  }

// Future<void> saveBookmark(ArticleEntity  article) async {
//   await _saveArticleBookmark(articleEntity: article);
//   // await getBookMarkedArticles();
//   notifyListeners();
// }
}
