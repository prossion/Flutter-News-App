import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/blocs/blocs.dart';
import 'package:flutter_news_app/src/models/models.dart';
import 'package:flutter_news_app/src/widgets/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<NewsBloc>().add(NewsFetched());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocListener<NewsBloc, NewsState>(
      listener: (context, state) {
        if (state is NewsInitState) {}
      },
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: ((context, state) {
          List<Articles> news = [];
          bool isLoading = false;
          if (state is NewsLoadingState && state.isFirstFetch) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NewsLoadingState) {
            news = state.oldArticles;
            isLoading = true;
          } else if (state is NewsLoadedState) {
            news = state.newsList;
          } else if (state is NewsErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.black, fontSize: 25),
              ),
            );
          }
          return ListView.separated(
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index < news.length) {
                return NewsCard(news: news[index]);
              } else {
                Timer(const Duration(milliseconds: 10), () {
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent);
                });
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            separatorBuilder: (context, builder) {
              return Container();
            },
            itemCount: news.length + (isLoading ? 1 : 0),
          );
        }),
      ),
    );
  }
}
