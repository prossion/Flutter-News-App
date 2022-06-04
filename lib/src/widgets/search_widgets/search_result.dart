// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/models/models.dart';
import 'package:flutter_news_app/src/screens/screens.dart';
import 'package:intl/intl.dart';

class SearchResult extends StatelessWidget {
  final Articles newsResult;
  const SearchResult({Key? key, required this.newsResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = newsResult.pubDate;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(news: newsResult),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            newsResult.imageUrl != null
                ? SizedBox(
                    child: CachedNetworkImage(
                      imageUrl: newsResult.imageUrl,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Image(
                          image: AssetImage('assets/icons/icon_error.png'),
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: Image(
                      image: AssetImage('assets/icons/icon_error.png'),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                newsResult.title,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
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
                newsResult.creator != null
                    ? Container(
                        color: Colors.black,
                        width: 1,
                        height: 11,
                      )
                    : const Divider(),
                newsResult.creator != null
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
                    newsResult.creator == null
                        ? ''
                        : 'News from: ${newsResult.creator}'
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
    );
  }
}
