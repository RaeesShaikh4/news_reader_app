// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
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

class HomeSCreen extends StatefulWidget {
  const HomeSCreen({super.key});

  @override
  State<HomeSCreen> createState() => _HomeSCreenState();
}

class _HomeSCreenState extends State<HomeSCreen> {

  String? userName;

  // Future<void> logout(BuildContext context) async {
  //   print('logeed out-----');
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  //   context.pushReplacement('/login');
  // }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsProvider>().getTopHeadlines();
      setName();
    });

  }

   setName() async{
    final result = await context.read<LoginProvider>().setUserName();
    userName = result;
  }

  

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      
       drawer: Consumer<NewsProvider>(
          builder:(context, provider, _) {
           return CustomizeDrawerScreen(userName,() async { 
                final result = await context.read<LoginProvider>().logout();
             if(result == true){
              context.pushReplacement('/login');
            }
           
           } 
           ,
           () {
             context.go('/bookmark');
           },
           () {
             
           },
           );
         }
       ),
      
      
      body:
      RefreshIndicator(
        onRefresh: () async {
    await context.read<NewsProvider>().getTopHeadlines();
    final box = Hive.box<ArticleModel>('BookMardked_articles');
    print('Count: ${box.length}');
    for (final article in box.values) {
      print(article.title);
    }
  },
        child: Consumer<NewsProvider>(
          builder:(context, provider, _) {
            if(provider.isLoading) return Center(child: CircularProgressIndicator());
        
            if(provider.status == ArticleStatus.error) {
              return _buildError(context, provider.error!);
            }
        
            return _buildList(provider.articles, context);
          }
        ),
      )
    );
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



  Widget _buildList(List<ArticleEntity> articles, BuildContext context) {
    return ListView.builder( 
      padding: const EdgeInsets.all(12),
      itemCount: articles.length,
      itemBuilder: (context, index) => articleCard(articles[index], context),
    );
  }

Widget articleCard(ArticleEntity article, BuildContext context) {
  return Card(
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
                          }, icon: Icon(
                            provider.isBookMark(article.url)
                            ? Icons.bookmark
                            : Icons.bookmark_border
                          ));
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
  );
}