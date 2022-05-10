import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/src/models/models.dart';

class NewsState extends Equatable {
  const NewsState();
  @override
  List<Object?> get props => [];
}

class NewsInitState extends NewsState {}

class NewsLoadingState extends NewsState {
  final List<Articles> oldArticles;
  final bool isFirstFetch;

  const NewsLoadingState(this.oldArticles, {this.isFirstFetch = false});
  @override
  List<Object?> get props => [oldArticles];
}

class NewsLoadedState extends NewsState {
  final List<Articles> newsList;

  const NewsLoadedState(this.newsList);
  @override
  List<Object?> get props => [newsList];
}

class NewsErrorState extends NewsState {
  final String message;

  const NewsErrorState({required this.message});
}
