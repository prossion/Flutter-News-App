import 'package:equatable/equatable.dart';

abstract class SearchNewsEvent extends Equatable {
  const SearchNewsEvent();

  @override
  List<Object?> get props => [];
}

class SearchNews extends SearchNewsEvent {
  final String query;

  const SearchNews(this.query);
}
