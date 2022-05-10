import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/blocs/blocs.dart';
import 'package:flutter_news_app/src/models/news_model.dart';
import 'package:flutter_news_app/src/repositories/repositories.dart';

class SearchNewsBloc extends Bloc<SearchNewsEvent, SearchNewsState> {
  final NewsRepository _repository;
  SearchNewsBloc({required final NewsRepository repository})
      : _repository = repository,
        super(SearchInitial()) {
    on<SearchNews>(
      ((event, emit) async {
        emit(SearchInitial());
        try {
          List<Articles> newsList = await _repository.searchNews(event.query);
          emit(SearchLoaded(newsList: newsList));
        } catch (_) {
          emit(SearchError());
          rethrow;
        }
      }),
    );
  }
}
