import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/blocs/blocs.dart';
import 'package:flutter_news_app/src/models/models.dart';
import 'package:flutter_news_app/src/repositories/repositories.dart';

class NewsBloc extends Bloc<NewsEvents, NewsState> {
  final NewsRepository newsRepository;
  int page = 1;

  NewsBloc({required this.newsRepository}) : super(NewsInitState()) {
    on<NewsFetched>((event, emit) async {
      if (state is NewsLoadingState) return;

      final currentState = state;

      var oldNews = <Articles>[];
      if (currentState is NewsLoadedState) {
        oldNews = currentState.newsList;
      }

      emit(NewsLoadingState(oldNews, isFirstFetch: page == 1));

      await newsRepository.getNews(page).then((newPosts) {
        page++;
        final posts = (state as NewsLoadingState).oldArticles;
        posts.addAll(newPosts);
        emit(NewsLoadedState(posts));
      });
    });
  }
}
