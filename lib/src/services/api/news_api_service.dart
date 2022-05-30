import 'dart:convert';

import 'package:flutter_news_app/src/models/models.dart';
import 'package:http/http.dart' as http;

class NewsService {
  final http.Client httpClient;
  static String mainUrl = 'https://newsdata.io/api/1/news';
  static String apiKey = 'pub_62462e93d9f35c6f1c383dd6a523a27f498e';

  NewsService({required this.httpClient});

  Future<List<Articles>> getNews(String category, int page) async {
    var response;
    if (category == 'all') {
      response = await httpClient.get(
        Uri.parse('$mainUrl?language=en&page=$page&apikey=$apiKey'),
        headers: {
          'Content-type': 'application/json',
        },
      );
    } else {
      response = await httpClient.get(
        Uri.parse(
            '$mainUrl?category=$category&language=en&page=$page&apikey=$apiKey'),
        headers: {
          'Content-type': 'application/json',
        },
      );
    }
    if (response.statusCode == 200) {
      final news = json.decode(response.body);
      return (news["results"] as List)
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

  Future<List<Articles>> searchNewses(String query) async {
    final response = await httpClient.get(
        Uri.parse('$mainUrl?language=en&q=$query&apikey=$apiKey'),
        headers: {
          'Content-type': 'application/json',
        });
    if (response.statusCode == 200) {
      final news = json.decode(response.body);
      return (news["results"] as List)
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
