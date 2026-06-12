import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();
  // https://newsapi.org/v2/top-headlines?country=us&apiKey=94b14c31cbb54f4a9907247d061f2f26

  static const String baseUrl = 'https://newsapi.org/v2';
  static const String topHeadlines = '/top-headlines';

  static String get apiKey => dotenv.env['NEWS_API_KEY'] ?? '';

  
}