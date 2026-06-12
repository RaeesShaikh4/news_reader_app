import 'package:dio/dio.dart';
import 'package:news_reader_app/core/exceptions/exceptions.dart';

class ExceptionHandler {
  static ApiException handle(DioException e) {
    switch(e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const NetworkException('Request Timeout');

      case DioExceptionType.connectionError:
        return const NetworkException();

      default :
        final statusCode = e.response?.statusCode;

        switch (statusCode) {
          case 400:
            return const BadRequestException();
          case 401:
            return const UnAuthorisedException();
          case 403:
            return const ForbiddenException();
          case 404:
            return const NotFoundException();
          case 429:
            return const TooManyRequestExceptions();
          case 500:
            return const InternalServerExceptions();
          
          default:
             return ApiException(
              e.response?.statusMessage ?? 'Something went wrong',
            );
        }
    }
  }
}