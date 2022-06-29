import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/blocs/blocs.dart';
import 'package:flutter_news_app/src/repositories/repositories.dart';

import 'config/app_theme.dart';
import 'src/screens/screens.dart';

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
              ..add(NewsFetchEvent(category: 'top')),
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
        child: BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
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
          },
        ),
      ),
    );
  }
}
