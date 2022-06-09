import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/blocs/news/news_events.dart';
import 'package:flutter_news_app/src/blocs/news/news_state.dart';
import 'package:flutter_news_app/src/models/models.dart';
import 'package:flutter_news_app/src/repositories/repositories.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;
  int page = 1;

  NewsBloc({required this.repository}) : super(NewsInitial()) {
    on<NewsFetchEvent>((event, emit) async {
      try {
        if (state is NewsLoadingState) return;

        final currentState = state;

        var oldNews = <Articles>[];
        if (currentState is NewsLoadedState) {
          oldNews = currentState.newsList;
        }

        emit(NewsLoadingState(oldNews, isFirstFetch: page == 1));

        await repository.getNews(event.category, page).then((newPosts) {
          page++;
          final posts = (state as NewsLoadingState).oldArticles;
          posts.addAll(newPosts);
          emit(NewsLoadedState(posts));
        });
      } catch (e) {
        emit(const NewsError('Unexpected Error! Please Try now!'));
        rethrow;
      }
    });
    on<ChangeCategoryTopNewsFetchEvent>(((event, emit) {
      emit(NewsChangedCategoryState(
          indexCategorySelected: event.indexCategorySelected));
    }));
  }
}
