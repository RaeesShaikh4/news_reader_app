import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_reader_app/core/utils/routes.dart';
import 'package:news_reader_app/di/injection_service.dart';
import 'package:news_reader_app/features/auth/presentation/provider/login_provider.dart';
import 'package:news_reader_app/features/auth/presentation/screens/login_screen.dart';
import 'package:news_reader_app/features/bookmarks/presentation/provider/bookmark_provider.dart';
import 'package:news_reader_app/features/home/data/models/article_model.dart';
import 'package:news_reader_app/features/home/presentation/provider/home_provider.dart';
import 'package:news_reader_app/features/home/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await dotenv.load(fileName: ".env");
 await Hive.initFlutter();
 Hive.registerAdapter(ArticleModelAdapter());
 await Hive.openBox<ArticleModel>('BookMardked_articles');
 await initDependencies();
 final prefs = await SharedPreferences.getInstance();
 final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp( MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
   MyApp({super.key, required this.isLoggedIn});
    late final _router = createRouter(isLoggedIn);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<LoginProvider>()),
        ChangeNotifierProvider(create: (_) => sl<NewsProvider>()),
        ChangeNotifierProvider(create: (_) => sl<BookMarkProvider>())
      ],
      child: MaterialApp.router(
        title: 'News Reader',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}
