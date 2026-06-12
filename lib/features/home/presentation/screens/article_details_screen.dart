import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_reader_app/core/constant/app_constants.dart';
import 'package:news_reader_app/core/utils/helper_functions.dart';
import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final ArticleEntity article;
  ArticleDetailsScreen({required this.article});

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();

}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: const Text('Article'),
  ),
  body: SafeArea(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
           widget.article.urlToImage ?? '',
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
    
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.article.sourceName,
                  style: TextStyle(
                    color: AppConstants.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
    
                const SizedBox(height: 8),
    
                Text(
                  widget.article.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
    
                const SizedBox(height: 12),
    
                Text(
                  widget.article.author ?? 'Unknown Author',
                  style: TextStyle(color: AppConstants.grey),
                ),
    
                const SizedBox(height: 8),
    
                Text(
                  DateFormat('dd MMM yyyy')
                      .format(widget.article.publishedAt!),
                  style: TextStyle(color: AppConstants.grey),
                ),
    
                const Divider(height: 32),
    
                Text(
                 widget.article.description ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
    
                const SizedBox(height: 20),
    
                Text(
                  widget.article.content ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
    
                const SizedBox(height: 24),
    
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      HelperFunctions.launchUrl(widget.article.url);
                    },
                    child: const Text(
                      'Read Original Article',
                    ),
                  ),
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

}