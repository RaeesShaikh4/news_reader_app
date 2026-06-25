import 'package:news_reader_app/core/utils/result.dart';
import 'package:news_reader_app/features/wall_street_journal/domain/entities/wall_street_news_entiry.dart';

abstract interface class WallStreetRepository {
  Future<Result<WallStreetNewsEntiry>> getWallStreeJournal();
}
