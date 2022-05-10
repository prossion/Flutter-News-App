import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/blocs/blocs.dart';
import 'package:flutter_news_app/src/repositories/repositories.dart';
import 'package:flutter_news_app/src/screens/screens.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.newsRepository}) : super(key: key);

  final NewsRepository newsRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider<NewsBloc>(
            create: (context) =>
                NewsBloc(newsRepository: newsRepository)..add(NewsFetched()),
          ),
          BlocProvider(
            create: (context) => SearchNewsBloc(repository: newsRepository),
          ),
        ],
        child: MaterialApp(
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomeScreen();
              } else {
                return const SignIn();
              }
            },
          ),
        ),
      ),
    );
  }
}
