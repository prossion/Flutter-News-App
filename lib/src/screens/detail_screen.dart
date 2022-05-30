import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/models/models.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatelessWidget {
  final Articles news;
  const DetailScreen({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = news.pubDate;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
      ),
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: news.imageUrl != null
                        ? NetworkImage(news.imageUrl)
                        : const AssetImage("assets/icons/icon_error.png")
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Positioned(
            //   top: 360,
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 20.0),
            //     child: Text(
            //       date == null
            //           ? ''
            //           : DateFormat.yMd().add_jm().format(date).toString(),
            //       style: const TextStyle(
            //           fontSize: 16, fontWeight: FontWeight.w600),
            //     ),
            //   ),
            // ),
            Positioned(
              top: 350,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 30.0),
                        child: Text(
                          news.title,
                          style: const TextStyle(
                              // color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                      news.category == null
                          ? Container()
                          : SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 20.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 80,
                                    height: 35,
                                    decoration: const BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: ((context, index) =>
                                            Center(
                                              child: Text(
                                                news.category[index],
                                              ),
                                            )),
                                        itemCount: 1,
                                        shrinkWrap: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10.0, bottom: 50.0),
                        child: Text(
                          news.content == null ? '' : news.content,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
