import 'package:news_reader_app/core/utils/result.dart';
import 'package:news_reader_app/features/auth/domain/repository/auth_repository.dart';
import 'package:news_reader_app/features/home/domain/entities/news_entity.dart';
import 'package:news_reader_app/features/home/domain/repositories/news_reposity.dart';

class LogInUseCase {
  final AuthLocalRepository repository;

  const LogInUseCase(this.repository);

  Future<bool> call({
    required String email,
    required String password,
  }) async{ return repository.login(email: email, passowrd: password);}
}