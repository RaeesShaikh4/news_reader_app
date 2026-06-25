import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_reader_app/core/constant/api_constants.dart';
import 'package:news_reader_app/core/exceptions/exception_handler.dart';
import 'package:news_reader_app/features/home/data/models/news_model.dart';
import 'package:news_reader_app/features/wall_street_journal/data/models/wall_street_news_model.dart';

abstract interface class WallStreetJournalRemoteDatasorce {
  Future<WallStreetNewsModel> getWallStreeJournal();
}

class WallStreetJournalRemoteDataSouceImpl
    implements WallStreetJournalRemoteDatasorce {
  final Dio dio;

  const WallStreetJournalRemoteDataSouceImpl(this.dio);

  @override
  Future<WallStreetNewsModel> getWallStreeJournal() async {
    try {
      final response = await dio.get(
        ApiConstants.wallStreesJournal,
        queryParameters: {
          'domains': ApiConstants.wallStreetDomains,
        },
      );

      return WallStreetNewsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }
}
