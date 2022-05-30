import 'package:equatable/equatable.dart';

class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsFetchEvent extends NewsEvent {
  final String category;

  NewsFetchEvent({required this.category});

  @override
  List<Object?> get props => [category];
}

class ChangeCategoryTopNewsFetchEvent extends NewsEvent {
  final int indexCategorySelected;

  ChangeCategoryTopNewsFetchEvent({required this.indexCategorySelected});

  @override
  List<Object?> get props => [indexCategorySelected];
}
