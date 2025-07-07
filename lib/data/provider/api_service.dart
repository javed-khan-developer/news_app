import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/core/utils/app_logger.dart';
import 'package:news_app/core/utils/app_snackbar.dart';
import '../model/news_model.dart';

class ApiService {
  static const _apiKey = '320fce0fa0974a6e9b5a8eb1366508d3';
  static const _baseUrl = 'https://newsapi.org/v2';
  static const _country = 'us';

  static Future<List<Article>> fetchNews(String category, int page) async {
    final url = Uri.parse(
      '$_baseUrl/top-headlines?country=$_country&category=$category&page=$page&pageSize=10&apiKey=$_apiKey',
    );
    AppLogger.log("GET: $url", tag: 'API', level: LogLevel.info);

    try {
      final response = await http.get(url);
      AppLogger.log("Status: ${response.statusCode}", tag: 'API');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        AppLogger.log(
          "Fetched ${data['articles'].length} articles",
          tag: 'API',
          level: LogLevel.success,
        );
        return (data['articles'] as List)
            .map((e) => Article.fromJson(e))
            .toList();
      } else {
        AppLogger.log(
          "API Error: ${response.body}",
          tag: 'API',
          level: LogLevel.error,
        );
        throw Exception("API Error");
      }
    } catch (e) {
      showAppSnackBar(
        "Error",
        'Failed to fetch articles. Please check your connection.',
      );

      AppLogger.log("Exception: $e", tag: 'API', level: LogLevel.error);
      rethrow;
    }
  }

  static Future<List<Article>> searchNews(String query) async {
    final url = Uri.parse('$_baseUrl/everything?q=$query&apiKey=$_apiKey');
    AppLogger.log("Searching for: '$query'", tag: 'API', level: LogLevel.info);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        AppLogger.log(
          "Search returned ${data['articles'].length} articles",
          tag: 'API',
          level: LogLevel.success,
        );
        return (data['articles'] as List)
            .map((e) => Article.fromJson(e))
            .toList();
      } else {
        AppLogger.log(
          "Search API error: ${response.body}",
          tag: 'API',
          level: LogLevel.error,
        );
        throw Exception("Search failed");
      }
    } catch (e) {
      AppLogger.log("Search Exception: $e", tag: 'API', level: LogLevel.error);
      showAppSnackBar(
        "Error",
        'Failed to search articles. Please check your connection.',
      );
      rethrow;
    }
  }
}
