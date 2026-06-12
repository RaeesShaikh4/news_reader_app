import 'package:news_reader_app/core/utils/result.dart';
import 'package:news_reader_app/features/auth/domain/repository/auth_repository.dart';

class SetUserNameCAse {
  final AuthLocalRepository repository;

  const SetUserNameCAse(this.repository);

  Future<String> call() => repository.setUserName();
}