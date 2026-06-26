// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:news_reader_app/core/widgets/custom_card.dart';
import 'package:news_reader_app/features/auth/presentation/provider/login_provider.dart';
import 'package:news_reader_app/features/auth/presentation/screens/login_screen.dart';
import 'package:news_reader_app/features/bookmarks/presentation/provider/bookmark_provider.dart';
import 'package:news_reader_app/features/home/data/models/article_model.dart';
import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';
import 'package:news_reader_app/features/home/presentation/provider/home_provider.dart';
import 'package:news_reader_app/features/home/presentation/screens/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookMarkProvider>().getBookMarkedArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BookMarks'),
        ),
        drawer: Consumer<NewsProvider>(builder: (context, provider, _) {
          return CustomizeDrawerScreen(
            email:  '',
           isLoggedOutTapped:  () async {
              final result = await context.read<LoginProvider>().logout();
              if (result == true) {
                context.read<BookMarkProvider>().clearBookmarks();
                context.pushReplacement('/login');
              }
            },
           toBookMarkScreen:  () {
            },
            
           toWallStreetHJournal:  () {
              context.go('/wallStreel');
            },
           toHomeScreen:  () {
            context.go('/home');

           },
          );
        }),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<BookMarkProvider>().getBookMarkedArticles();
          },
          child: Consumer<BookMarkProvider>(builder: (context, provider, _) {
            if (provider.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (provider.bookMarkedArticles.isEmpty) {
              return _buildError(context, 'No Data Found');
            }

            return _buildList(provider.bookMarkedArticles, context);
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
          onPressed: () =>
              context.read<BookMarkProvider>().getBookMarkedArticles(),
          icon: const Icon(Icons.refresh),
          label: const Text('Retry'),
        ),
      ],
    ),
  );
}

Widget _buildList(List<ArticleEntity> articles, BuildContext context) {
  return ListView.builder(
    padding: const EdgeInsets.all(12),
    itemCount: articles.length,
    itemBuilder: (context, index) => ArticlCard(article: articles[index], onCardTap: () {
      context.push('/article_detail', extra: articles[index]);
    },
    )
  );
}
