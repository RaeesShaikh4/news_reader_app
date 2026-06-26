// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:news_reader_app/core/constant/app_constants.dart';
import 'package:news_reader_app/core/widgets/custom_card.dart';
import 'package:news_reader_app/features/auth/presentation/provider/login_provider.dart';
import 'package:news_reader_app/features/bookmarks/presentation/provider/bookmark_provider.dart';
import 'package:news_reader_app/features/home/presentation/provider/home_provider.dart';
import 'package:news_reader_app/features/home/presentation/screens/widgets/custom_drawer.dart';
import 'package:news_reader_app/features/wall_street_journal/domain/entities/wall_street_article_entity.dart';
import 'package:news_reader_app/features/wall_street_journal/presentations/provider/wall_street_provider.dart';
import 'package:provider/provider.dart';

class WallStreetScreen extends StatefulWidget {
  const WallStreetScreen({super.key});

  @override
  State<WallStreetScreen> createState() => WallStreetScreenState();
}

class WallStreetScreenState extends State<WallStreetScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WallStreetProvider>().getWallStreetJournal();
      context.read<BookMarkProvider>().getBookMarkedArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wall Street Journal'),
          iconTheme: IconThemeData(color: AppConstants.blue),
        ),
        drawer: Consumer<WallStreetProvider>(builder: (context, provider, _) {
          return CustomizeDrawerScreen(
            selectedItem: DrawerItem.wallstreet,
            isLoggedOutTapped: () async {
              final result = await context.read<LoginProvider>().logout();
              if (result == true) {
                context.read<BookMarkProvider>().clearBookmarks();
                context.pushReplacement('/login');
              }
            },
            toBookMarkScreen: () {
              context.go('/bookmark');
            },
            toWallStreetHJournal: () {
              // context.go('/wallStreel');
            },
            toHomeScreen: () {
              context.go('/home');
            },
          );
        }),
        body: RefreshIndicator(
          onRefresh: () async {
            // await context.read<NewsProvider>().getTopHeadlines();
            // final box = Hive.box<ArticleModel>('BookMardked_articles');
            // print('Count: ${box.length}');
            // for (final article in box.values) {
            //   print(article.title);
            // }
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<WallStreetProvider>().getWallStreetJournal();
              context.read<BookMarkProvider>().getBookMarkedArticles();
            });
          },
          child: Consumer<WallStreetProvider>(builder: (context, provider, _) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (provider.status == WallStreetArtivcleStatus.error) {
              return _buildError(context, provider.error!);
            }

            return _buildList(provider.articles, context);
          }),
        ));
  }
}

Widget _buildError(BuildContext context, String message) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 56),
        const SizedBox(height: 12),
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () => context.read<NewsProvider>().getTopHeadlines(),
          icon: const Icon(Icons.refresh),
          label: const Text('Retry'),
        ),
      ],
    ),
  );
}

Widget _buildList(
    List<WallStreetArticleEntity> articles, BuildContext context) {
  return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: articles.length,
      itemBuilder: (context, index) => ArticlCard(
            article: articles[index],
            onCardTap: () {
              context.push('/article_detail', extra: articles[index]);
            },
          ));
}
