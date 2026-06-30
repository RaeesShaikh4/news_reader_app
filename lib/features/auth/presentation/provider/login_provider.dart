
import 'package:flutter/material.dart';
import 'package:news_reader_app/di/injection_service.dart';
import 'package:news_reader_app/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:news_reader_app/features/auth/domain/use_cases/log_out_use_case.dart';
import 'package:news_reader_app/features/auth/domain/use_cases/set_user_name_case.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class LoginProvider with ChangeNotifier {
class LoginProvider extends ChangeNotifier {
  final LogOutUseCase _logOutUseCase;
  final LogInUseCase _logInUseCase;
  final SetUserNameCAse _setUserNameCase; 

  LoginProvider({
    required LogOutUseCase logOutUseCase,
    required LogInUseCase logInUseCase,
    required SetUserNameCAse setUserNameCase,
  }) : _logOutUseCase = logOutUseCase, _logInUseCase = logInUseCase,  _setUserNameCase = setUserNameCase ;
  String? _emailError;
  String? _passWordError;

  String? get emailError => _emailError;
  String? get passwordError => _passWordError;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  bool _initialised = false;
  bool get initialised => _initialised;
  final SharedPreferences prefs = sl<SharedPreferences>();

  Future<void> initialize() async {
    // final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _initialised = true;
    notifyListeners();
  }

  bool validateEmail(String email) {
   print('Email validation called');
    if(email.isEmpty || email == null) {
      _emailError = 'Please Enter Email';
      notifyListeners();
      return false;
    }

    final emailRegex = RegExp(
     r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if(!emailRegex.hasMatch(email)) {
      _emailError = 'Please enter valid email';
      notifyListeners();
      return false;
    }

    _emailError = null;
    notifyListeners();
    return true;
  }


  bool validatePassword(String value){
    if(value.isEmpty || value == null) {
      _passWordError = "Please enter password";
      notifyListeners();
      return false;
    }

    if(value.length < 6){
      _passWordError = "Password should be greater than 6 chanracters";
      notifyListeners();
      return false;
    }

    _passWordError = null;
    notifyListeners();
    return true;
  }


  Future<bool> login({
    required String email,
    required String passowrd
  }) async{
    print('login tapped--');
    final isEamilValid = validateEmail(email);
    final isPasswordValid = validatePassword(passowrd);

    if(!isEamilValid || !isPasswordValid) {
      print('something is invalid');
      return false;
    } 

     final result = await _logInUseCase(
      email: email,
      password: passowrd,
    );

    if(result){
      _isLoggedIn = true;
      notifyListeners();
    }

    return result;
  }

   Future<bool> logout() async {
    print('logeed out-----');
    // final prefs = await SharedPreferences.getInstance();
    final result = await _logOutUseCase(); 
    _isLoggedIn = false;
    // context.pushReplacement('/login');
    notifyListeners();
    return result;
  }


  Future<String> setUserName() async{
    print('set user name called-----');
    final result = await _setUserNameCase();
     notifyListeners();
     return result;
  }
  

 }


