import 'dart:convert';

import 'package:flutter_news_app/src/models/models.dart';
import 'package:http/http.dart' as http;

class NewsService {
  final http.Client httpClient;

  NewsService({required this.httpClient});

  Future<List<Articles>> getNewses(int page) => _getNewsesFromUri(
      'https://api.newscatcherapi.com/v2/latest_headlines?lang=en&countries=UA&page_size=10&page=$page');

  Future<List<Articles>> searchNewses(String query) => _getNewsesFromUri(
      'https://api.newscatcherapi.com/v2/search?q=$query&lang=en');

  Future<List<Articles>> _getNewsesFromUri(String url) async {
    final response = await httpClient.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'x-api-key': 'TiX1UlWns6qpZTDtPLfs8d1RdH0nCVOS62_UFBDjxms'
    });
    if (response.statusCode == 200) {
      final news = json.decode(response.body);
      return (news["articles"] as List)
          .map((newses) => Articles.fromJson(newses))
          .toList();
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (response.statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Something does wen't wrong");
    }
  }
}
