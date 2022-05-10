import 'package:flutter_news_app/src/models/models.dart';
import 'package:flutter_news_app/src/services/api/news_api_service.dart';

class NewsRepository {
  final NewsService newsService;

  NewsRepository({required this.newsService});

  Future<List<Articles>> getNews(page) => newsService.getNewses(page);

  Future<List<Articles>> searchNews(query) => newsService.searchNewses(query);
}
