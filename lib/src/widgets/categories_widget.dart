import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/blocs/blocs.dart';

import '../models/models.dart';

class WidgetCategoryNews extends StatefulWidget {
  final List<CategoryModel> listCategories;
  final int indexDefaultSelected;

  const WidgetCategoryNews({
    Key? key,
    required this.listCategories,
    required this.indexDefaultSelected,
  }) : super(key: key);

  @override
  State<WidgetCategoryNews> createState() => _WidgetCategoryNewsState();
}

class _WidgetCategoryNewsState extends State<WidgetCategoryNews> {
  late int indexCategorySelected;

  @override
  void initState() {
    indexCategorySelected = widget.indexDefaultSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        height: 74,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            var itemCategory = widget.listCategories[index];
            return Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: index == widget.listCategories.length - 1 ? 16.0 : 0.0,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (indexCategorySelected == index) {
                        return;
                      }
                      setState(() => indexCategorySelected = index);
                      var topHeadlinesNewsBloc =
                          BlocProvider.of<NewsBloc>(context);
                      topHeadlinesNewsBloc.add(
                        ChangeCategoryTopNewsFetchEvent(
                            indexCategorySelected: index),
                      );
                    },
                    child: index == 0
                        ? Container(
                            width: 48.0,
                            height: 48.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.withOpacity(0.5),
                              border: indexCategorySelected == index
                                  ? Border.all(
                                      color: Colors.white,
                                      width: 5.0,
                                    )
                                  : null,
                            ),
                            child: const Icon(
                              Icons.format_align_left,
                              color: Colors.white,
                            ),
                          )
                        : Container(
                            width: 48.0,
                            height: 48.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: indexCategorySelected == index
                                    ? AssetImage(itemCategory.image
                                        .replaceAll('_white', ''))
                                    : AssetImage(itemCategory.image),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    itemCategory.title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: indexCategorySelected == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  )
                ],
              ),
            );
          }),
          itemCount: widget.listCategories.length,
        ),
      ),
    );
  }
}
