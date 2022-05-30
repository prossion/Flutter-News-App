import 'package:flutter_news_app/src/models/models.dart';
import 'package:flutter_news_app/src/services/api/news_api_service.dart';

class NewsRepository {
  final NewsService newsService;

  NewsRepository({required this.newsService});

  Future<List<Articles>> searchNews(query) => newsService.searchNewses(query);

  Future<List<Articles>> getNews(category, page) =>
      newsService.getNews(category, page);
}
