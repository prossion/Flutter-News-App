import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/config/app_theme.dart';
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
  final osThemeIsLight =
      WidgetsBinding.instance.window.platformBrightness == Brightness.light;
  MyApp({Key? key, required this.newsRepository}) : super(key: key);

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
          BlocProvider(
            create: (context) => SearchNewsBloc(repository: newsRepository),
          ),
          BlocProvider(
            create: (context) => NewsBloc(repository: newsRepository)
              ..add(NewsFetchEvent(category: 'world')),
          ),
          // If Android/IOS theme of the device is light, start app with light theme,
          // else start app with dark theme
          osThemeIsLight
              ? BlocProvider(
                  create: (context) =>
                      ThemeCubit(initialTheme: AppThemes.lightTheme))
              : BlocProvider(
                  create: (context) =>
                      ThemeCubit(initialTheme: AppThemes.darkTheme)),
        ],
        child: BlocBuilder<ThemeCubit, ThemeData>(builder: (context, state) {
          return MaterialApp(
            theme: state,
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const MainScreen();
                } else {
                  return const SignIn();
                }
              },
            ),
          );
        }),
      ),
    );
  }
}
