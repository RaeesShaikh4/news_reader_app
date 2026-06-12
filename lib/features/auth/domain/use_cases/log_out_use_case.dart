import 'package:news_reader_app/core/utils/result.dart';
import 'package:news_reader_app/features/auth/domain/repository/auth_repository.dart';
import 'package:news_reader_app/features/home/domain/entities/news_entity.dart';
import 'package:news_reader_app/features/home/domain/repositories/news_reposity.dart';

class LogOutUseCase {
  final AuthLocalRepository repository;

  const LogOutUseCase(this.repository);

  Future<bool> call() => repository.logout();
}