import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/blocs/blocs.dart';
import 'package:flutter_news_app/src/models/models.dart';
import 'package:flutter_news_app/src/widgets/search_widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search News...');

  final _suggestions = [
    'Ukraine',
    'Europe',
    'Crypto',
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return (IconButton(
        onPressed: () => close(context, null),
        tooltip: 'Close',
        icon: const Icon(Icons.arrow_back)));
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<SearchNewsBloc>(context, listen: false)
        .add(SearchNews(query));

    return BlocBuilder<SearchNewsBloc, SearchNewsState>(
      builder: ((context, state) {
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchLoaded) {
          final newsList = state.newsList;
          if (newsList.isEmpty) {
            return const Center(
              child: AlertDialog(
                content: Text('No news with that name found'),
              ),
            );
          }
          return ListView.builder(
            itemCount: newsList.isNotEmpty ? newsList.length : 0,
            itemBuilder: (context, int index) {
              Articles result = newsList[index];
              return SearchResult(newsResult: result);
            },
          );
        } else if (state is SearchError) {
          return const AlertDialog(
            title: Text('Ooops...'),
            content: Text('Error! Please try now!'),
          );
        }
        return Container();
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }
    return ListView.separated(
        itemBuilder: ((context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _suggestions[index],
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            )),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: _suggestions.length);
  }
}
