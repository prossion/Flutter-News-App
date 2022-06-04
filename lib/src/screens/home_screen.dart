import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/blocs/blocs.dart';
import 'package:flutter_news_app/src/models/models.dart';
import 'package:flutter_news_app/src/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final listCategories = [
    CategoryModel('', 'All'),
    CategoryModel('assets/icons/business.png', 'Business'),
    CategoryModel('assets/icons/entertainment.png', 'Entertainment'),
    CategoryModel('assets/icons/health.png', 'Health'),
    CategoryModel('assets/icons/politics.png', 'Politics'),
    CategoryModel('assets/icons/science.png', 'Science'),
    CategoryModel('assets/icons/sport.png', 'Sports'),
    CategoryModel('assets/icons/technology.png', 'Technology'),
    CategoryModel('assets/icons/world.png', 'World'),
  ];
  int indexSelectedCategory = 0;
  final refreshIndicatorState = GlobalKey<RefreshIndicatorState>();
  var completerRefresh = Completer();

  final ScrollController scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<NewsBloc>().add(NewsFetchEvent(
              category:
                  listCategories[indexSelectedCategory].title.toLowerCase()));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter News'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: BlocListener<NewsBloc, NewsState>(
          listener: (context, state) {
            if (state is NewsLoadedState) {
              return _resetRefreshIndicator();
            } else if (state is NewsChangedCategoryState) {
              indexSelectedCategory = state.indexCategorySelected;
              refreshIndicatorState.currentState!.show();
            }
          },
          child: Column(
            children: [
              WidgetCategoryNews(
                  listCategories: listCategories,
                  indexDefaultSelected: indexSelectedCategory),
              const SizedBox(height: 10),
              Expanded(
                child: _buildWidgetContent(),
              ),
            ],
          )),
    );
  }

  void _resetRefreshIndicator() {
    completerRefresh.complete();
    completerRefresh = Completer();
  }

  Widget _buildWidgetContent() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        List<Articles> newsList = [];
        if (state is NewsLoadingState && state.isFirstFetch) {
          refreshIndicatorState.currentState!.show();
        } else if (state is NewsLoadingState) {
          newsList = state.oldArticles;
        } else if (state is NewsLoadedState) {
          newsList = state.newsList;
        } else if (state is NewsError) {
          return const AlertDialog(
            title: Text('Ooops...'),
            content: Text('Unexpected Error, try now!'),
          );
        }
        return Stack(
          children: <Widget>[
            RefreshIndicator(
              key: refreshIndicatorState,
              onRefresh: () {
                BlocProvider.of<NewsBloc>(context).add(
                  NewsFetchEvent(
                    category: listCategories[indexSelectedCategory]
                        .title
                        .toLowerCase(),
                  ),
                );
                return completerRefresh.future;
              },
              child: ListView.separated(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                itemBuilder: (context, index) {
                  if (index < newsList.length) {
                    return NewsCard(news: newsList[index]);
                  } else {
                    Timer(const Duration(milliseconds: 10), () {
                      scrollController
                          .jumpTo(scrollController.position.maxScrollExtent);
                    });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                separatorBuilder: (context, builder) {
                  return Container();
                },
                itemCount: newsList.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
