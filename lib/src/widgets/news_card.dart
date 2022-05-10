import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/models/models.dart';
import 'package:flutter_news_app/src/screens/detail_screen.dart';

class NewsCard extends StatelessWidget {
  final Articles news;
  const NewsCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: CachedNetworkImage(
                  imageUrl: news.media,
                  placeholder: (context, url) => Container(
                      height: 40,
                      width: 40,
                      child: const CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Image(
                    image: AssetImage('assets/icons/icon_error.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Text(news.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w400)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Text(
                  news.excerpt == null ? '' : news.excerpt,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          news.publishedDate == null ? '' : news.publishedDate),
                    ),
                  ),
                  news.author != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Container(
                            color: Colors.black45,
                            height: 15,
                            width: 2,
                          ),
                        )
                      : Container(),
                  Expanded(
                    child: Text(
                      news.author == null ? '' : 'News from: ${news.author}',
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
