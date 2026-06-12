import 'package:news_reader_app/core/exceptions/exceptions.dart';

sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

final class Failure<T> extends Result<T> {
  final ApiException exception;
  const Failure(this.exception);
}