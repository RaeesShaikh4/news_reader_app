import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_reader_app/core/constant/app_constants.dart';
import 'package:news_reader_app/features/bookmarks/presentation/provider/bookmark_provider.dart';
import 'package:news_reader_app/features/home/domain/entities/article_entity.dart';
import 'package:provider/provider.dart';

class ArticlCard extends StatelessWidget {
  final ArticleEntity article;
  final VoidCallback onCardTap;

  const ArticlCard({
    super.key,
    required this.article,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.urlToImage != null
                ? Image.network(
                    article.urlToImage!,
                    width: double.infinity,
                    height: 170,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 170,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image,
                        size: 60,
                      ),
                    ),
                  )
                : Container(
                    height: 170,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image,
                      size: 60,
                    ),
                  ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          article.sourceName,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: AppConstants.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Consumer<BookMarkProvider>(
                        builder: (context, provider, _) {
                          final isBookmarked =
                              provider.isBookMark(article.url);

                          return GestureDetector(
                            onTap: () {
                              provider.toggleBookMark(article);
                            },
                            child: Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              size: 22,
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 8),

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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}