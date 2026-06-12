import 'package:news_reader_app/core/utils/result.dart';
import 'package:news_reader_app/features/home/domain/entities/news_entity.dart';

abstract interface class AuthLocalRepository {
   Future<bool> logout();
   Future<bool> login({
    required String email,
    required String passowrd
  }); 
    Future<String> setUserName(); 

}