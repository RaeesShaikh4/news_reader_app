import 'package:news_reader_app/core/exceptions/exceptions.dart';
import 'package:news_reader_app/core/utils/result.dart';
import 'package:news_reader_app/features/wall_street_journal/data/data_sources/wall_street_journal_remote_datasorce.dart';
import 'package:news_reader_app/features/wall_street_journal/domain/entities/wall_street_news_entiry.dart';
import 'package:news_reader_app/features/wall_street_journal/domain/repositories/wall_street_repository.dart';

class WallStreetJournalRemoteRepositoryImpl implements WallStreetRepository {
  final WallStreetJournalRemoteDatasorce dataSource;
  const WallStreetJournalRemoteRepositoryImpl(this.dataSource);

  @override
  Future<Result<WallStreetNewsEntiry>> getWallStreeJournal() async {
    try {
      final wallStreetNewsModel = await dataSource.getWallStreeJournal();
      return Success(wallStreetNewsModel.toEntity());
    } on ApiException catch (e) {
      return Failure(e);
    }
  }
}
