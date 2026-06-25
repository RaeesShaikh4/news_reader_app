// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wall Street Journal'),
        ),
        drawer: Consumer<WallStreetProvider>(builder: (context, provider, _) {
          return CustomizeDrawerScreen(
            email: '',
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
              context.go('/wallStreel');
            },
            toHomeScreen: () {},
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
            });
          },
          child: Consumer<WallStreetProvider>(builder: (context, provider, _) {
            if (provider.isLoading)
              return Center(child: CircularProgressIndicator());

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
    itemBuilder: (context, index) => articleCard(articles[index], context),
  );
}

Widget articleCard(WallStreetArticleEntity article, BuildContext context) {
  return GestureDetector(
    onTap: () {
      context.push('/article_detail', extra: article);
    },
    child: Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: article.urlToImage != null
                  ? Image.network(
                      article.urlToImage!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image, size: 100),
                    )
                  : const Icon(Icons.image, size: 100),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.sourceName,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        article.publishedAt != null
                            ? DateFormat('dd MMM yyyy')
                                .format(article.publishedAt!)
                            : '',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),

                      // ElevatedButton(
                      //   onPressed: () {
                      //     context.read<BookMarkProvider>().saveBookmark(article);
                      //   },
                      //   child: Text('BookMark')
                      // )
                      Consumer<BookMarkProvider>(
                        builder: (context, provider, _) {
                          return IconButton(
                              onPressed: () {
                                provider.toggleBookMark(article);
                              },
                              icon: Icon(provider.isBookMark(article.url)
                                  ? Icons.bookmark
                                  : Icons.bookmark_border));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
