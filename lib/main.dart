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
import 'package:news_reader_app/features/wall_street_journal/data/models/wall_street_article_model.dart';
import 'package:news_reader_app/features/wall_street_journal/presentations/provider/wall_street_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleModelAdapter());
  Hive.registerAdapter(WallStreetArticleModelAdapter());
  final userId = prefs.getInt('userId');
  print('userId-----$userId');
  final userBoxName = 'bookmarks_$userId';
  final wallStreetBoxName = 'wallstreet_bookmarks_$userId';
  final articleBox = await Hive.openBox<ArticleModel>(userBoxName);
  // final wallStreetArticleBox =
  //     await Hive.openBox<WallStreetArticleModel>(wallStreetBoxName);
  await initDependencies(
    articleBox: articleBox,
    // wallStreetArticleBox: wallStreetArticleBox,
  );
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(RestartWidget(child: MyApp(isLoggedIn: isLoggedIn)));
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
        ChangeNotifierProvider(create: (_) => sl<BookMarkProvider>()),
        ChangeNotifierProvider(create: (_) => sl<WallStreetProvider>()),
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



class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget({
    super.key,
    required this.child,
  });

  static void restartApp(BuildContext context) {
    final state =
        context.findAncestorStateOfType<_RestartWidgetState>();

    state?.restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key _key = UniqueKey();

  void restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: widget.child,
    );
  }
}