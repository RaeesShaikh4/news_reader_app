import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_reader_app/core/constant/api_constants.dart';
import 'package:news_reader_app/core/exceptions/exception_handler.dart';
import 'package:news_reader_app/features/home/data/models/news_model.dart';

abstract interface class NewsRemoteDataSource {
  Future<NewsModel> getTopHeadlines();
  
}

class NewsRemoteDataSouceImpl implements NewsRemoteDataSource {
  final Dio dio;

  const NewsRemoteDataSouceImpl(this.dio);
  
  @override
  Future<NewsModel> getTopHeadlines() async { 
    try {
    final response = await dio.get(
      ApiConstants.topHeadlines,
     queryParameters: {
        'country': 'us',
      },
    );

    return NewsModel.fromJson(response.data);
    } on DioException catch(e) {
      throw ExceptionHandler.handle(e);
    }
  } 

  
}