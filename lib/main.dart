import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/app.dart';
import 'package:flutter_news_app/src/repositories/repositories.dart';
import 'package:flutter_news_app/src/services/services.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final newsRepository =
      NewsRepository(newsService: NewsService(httpClient: http.Client()));
  runApp(MyApp(
    newsRepository: newsRepository,
  ));
}
