import 'package:news_reader_app/core/exceptions/exceptions.dart';
import 'package:news_reader_app/features/auth/data/data_source/auth_local_datasource.dart';
import 'package:news_reader_app/features/auth/domain/repository/auth_repository.dart';

class AuthLocalRepositoryImpl implements AuthLocalRepository {
  final AuthLocalDataSource dataSource;
  const AuthLocalRepositoryImpl(this.dataSource);
  
  @override
  Future<bool> logout() async{
    try {
      final result = await dataSource.logout();
      return result;
    } catch(e){
      return false;

    }
  }
  
  @override
  Future<bool> login({required String email, required String passowrd}) async { 
    try {
      final result = await dataSource.login(email: email, passowrd: passowrd);
      return result;
    } catch (e) {
      return false;

    }
  }
  

    @override
  Future<String> setUserName() async{
      try {
      final userName = await dataSource.setUserName();
      return userName ;
      } on ApiException catch (e) {
        return '';
      }
  } 

}