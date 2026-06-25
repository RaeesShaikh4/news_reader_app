import 'package:news_reader_app/core/utils/result.dart';
import 'package:news_reader_app/features/wall_street_journal/domain/entities/wall_street_news_entiry.dart';
import 'package:news_reader_app/features/wall_street_journal/domain/repositories/wall_street_repository.dart';

class GetWallStreetJournalUseCase {
  final WallStreetRepository repository;

  const GetWallStreetJournalUseCase(this.repository);

  Future<Result<WallStreetNewsEntiry>> call() =>
      repository.getWallStreeJournal();
}
