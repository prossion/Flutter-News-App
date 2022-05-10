import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/src/models/models.dart';

abstract class SearchNewsState extends Equatable {
  const SearchNewsState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchNewsState {
  @override
  List<Object?> get props => [];
}

class SearchLoading extends SearchNewsState {
  @override
  List<Object?> get props => [];
}

class SearchLoaded extends SearchNewsState {
  final List<Articles> newsList;

  const SearchLoaded({required this.newsList});
  @override
  List<Object?> get props => [newsList];
}

class SearchError extends SearchNewsState {
  @override
  List<Object?> get props => [];
}
