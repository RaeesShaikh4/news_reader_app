import 'package:hive/hive.dart';
import 'package:news_reader_app/di/injection_service.dart';
import 'package:news_reader_app/features/auth/presentation/provider/login_provider.dart';
import 'package:news_reader_app/features/home/data/models/article_model.dart';
import 'package:news_reader_app/features/wall_street_journal/data/models/wall_street_article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AuthLocalDataSource {
  Future<bool> logout();
  Future<bool> login({required String email, required String passowrd});
  Future<void> saveLoginStatus(bool isLoggedIn, String? userEmail);
  Future<String> setUserName();
}

class AuthLocalDataSourceImple implements AuthLocalDataSource {
  // final Dio dio;
  final SharedPreferences prefs;

  const AuthLocalDataSourceImple(this.prefs);

  @override
  Future<bool> logout() async {
    final userId = prefs.getInt('userId');
    print('logeed out-----');
    await prefs.clear();
    await Hive.box<ArticleModel>('bookmarks_$userId').close();
    // await Hive.box<WallStreetArticleModel>('wallstreet_bookmarks_$userId')
    //     .close();

    // context.pushReplacement('/login');
    return true;
  }

  Future<bool> login({required String email, required String passowrd}) async {
    await saveLoginStatus(true, email);
    final userId = prefs.getInt('userId')!;
    await initalizeBoxesAndSwithUser(userId);

    return true;
  }

  Future<void> initalizeBoxesAndSwithUser(int userId) async {
    print('initalizeBoxesAndSwithUser userId----- $userId');
    await sl.reset();

    final articleBox = await Hive.openBox<ArticleModel>('bookmarks_$userId');

    final wallStreetBox = await Hive.openBox<WallStreetArticleModel>(
        'wallstreet_bookmarks_$userId');

    await initDependencies(
      articleBox: articleBox,
      // wallStreetArticleBox: wallStreetBox,
    );

    // After re-initializing dependencies, sync the session state on the new LoginProvider instance
    await sl<LoginProvider>().initialize();
  }

  Future<void> saveLoginStatus(bool isLoggedIn, String? userEmail) async {
    int userId = 0;
    if (userEmail == 'raees@gmail.com') {
      userId = 1;
    } else if (userEmail == 'test@gmail.com') {
      userId = 2;
    } else if (userEmail == 'mark@gmail.com') {
      userId = 3;
    }

    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setString('userEmail', userEmail ?? '');
    await prefs.setInt('userId', userId);
  }

  @override
  Future<String> setUserName() async {
    // final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return prefs.getString('userEmail') ?? '';
  }
}
