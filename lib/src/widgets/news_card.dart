// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/models/models.dart';
import 'package:flutter_news_app/src/screens/detail_screen.dart';
import 'package:intl/intl.dart';

class NewsCard extends StatelessWidget {
  final Articles news;
  const NewsCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = news.pubDate;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(news: news)));
          },
          child: Column(
            children: [
              news.imageUrl != null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: CachedNetworkImage(
                        imageUrl: news.imageUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Image(
                          image: AssetImage('assets/icons/icon_error.png'),
                        ),
                      ),
                    )
                  : const Image(
                      image: AssetImage('assets/icons/icon_error.png')),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Text(news.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w400)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Text(
                  news.description == null ? '' : news.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 8.0, bottom: 8.0, right: 2.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(date == null
                          ? ''
                          : DateFormat.yMd().add_jm().format(date).toString()),
                    ),
                  ),
                  news.creator != null
                      ? Container(
                          color: Colors.black,
                          width: 1,
                          height: 11,
                        )
                      : const Divider(),
                  news.creator != null
                      ? const Padding(
                          padding:
                              EdgeInsets.only(left: 1.0, top: 8.0, bottom: 8.0),
                          child: SizedBox(
                            height: 15,
                            width: 2,
                          ),
                        )
                      : const Divider(),
                  Expanded(
                    child: Text(
                      news.creator == null
                          ? ''
                          : 'News from: ${news.creator}'
                              .replaceAll('[', '')
                              .replaceAll(']', ''),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
