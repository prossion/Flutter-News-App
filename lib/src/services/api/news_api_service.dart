import 'dart:convert';

import 'package:flutter_news_app/src/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewsService {
  final http.Client httpClient;
  final _prefs = SharedPreferences.getInstance();

  String cntry = 'us';
  static String mainUrl = 'https://newsdata.io/api/1/news';
  static String apiKey = 'pub_62462e93d9f35c6f1c383dd6a523a27f498e';

  NewsService({required this.httpClient});

  Future<List<Articles>> getNews(String category, int page) async {
    final SharedPreferences pref = await _prefs;
    String? country = pref.getString('country');
    http.Response response;

    if (country == 'USA') {
      cntry = 'us';
    } else if (country == 'Germany') {
      cntry = 'de';
    } else if (country == 'United Kingdom') {
      cntry = 'gb';
    } else if (country == 'France') {
      cntry = 'fr';
    } else if (country == 'Ukraine') {
      cntry = 'ua';
    } else if (country == 'Poland') {
      cntry = 'pl';
    }

    if (category == 'all') {
      response = await httpClient.get(
        Uri.parse('$mainUrl?country=$cntry&page=$page&apikey=$apiKey'),
        headers: {
          'Content-type': 'application/json',
        },
      );
    } else {
      response = await httpClient.get(
        Uri.parse(
            '$mainUrl?category=$category&country=$cntry&page=$page&apikey=$apiKey'),
        headers: {
          'Content-type': 'application/json',
        },
      );
    }
    if (response.statusCode == 200) {
      final news = json.decode(utf8.decode(response.bodyBytes));
      return (news["results"] as List)
          .map((newses) => Articles.fromJson(newses))
          .toList();
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (response.statusCode == 500) {
      throw Exception("Server Error");
    } else if (response.body.isEmpty) {
      throw Exception(
          "There is no news in this category,\n choose another or change the country");
    } else {
      throw Exception("Something does wen't wrong");
    }
  }

  Future<List<Articles>> searchNewses(String query) async {
    final response = await httpClient
        .get(Uri.parse('$mainUrl?q=$query&apikey=$apiKey'), headers: {
      'Content-type': 'application/json',
    });
    if (response.statusCode == 200) {
      final news = json.decode(utf8.decode(response.bodyBytes));
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
