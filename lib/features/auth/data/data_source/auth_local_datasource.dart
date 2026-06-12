

import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AuthLocalDataSource {
  Future<bool> logout();
  Future<bool> login({
    required String email,
    required String passowrd
  });
  Future<void> saveLoginStatus(bool isLoggedIn, String? userEmail);
  Future<String> setUserName(); 

}

class AuthLocalDataSourceImple implements AuthLocalDataSource {
  // final Dio dio;
  final  SharedPreferences prefs;

  const AuthLocalDataSourceImple(this.prefs);

  @override
  Future<bool> logout() async {
    print('logeed out-----');
    await prefs.clear();
    // context.pushReplacement('/login');
    return true;
  }

   Future<bool> login({
    required String email,
    required String passowrd
  }) async{
    await saveLoginStatus(true, email);
    return true;
  }

  Future<void> saveLoginStatus(bool isLoggedIn, String? userEmail) async { 

    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setString('userEmail', userEmail ?? ''); 
  }

  @override
Future<String> setUserName() async{
    // final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return prefs.getString('userEmail') ?? '';
  }



  
}