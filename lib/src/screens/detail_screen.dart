// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/models/models.dart';

class DetailScreen extends StatelessWidget {
  final Articles news;
  const DetailScreen({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            left: 20.0, right: 20.0, top: 10.0),
                        child: Text(
                          news.title,
                          style: const TextStyle(
                              // color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                      news.category == null
                          ? const Divider()
                          : Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 200,
                                  height: 25,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: ((context, index) => Center(
                                          child: Text(
                                            '#${news.category[index]}'
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )),
                                    itemCount: 1,
                                    shrinkWrap: true,
                                  ),
                                ),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              news.creator == null
                                  ? const Divider()
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: SizedBox(
                                        width: 200,
                                        height: 30,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: ((context, index) => Row(
                                                children: [
                                                  const Text(
                                                    'Creator:',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    news.creator[index],
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              )),
                                          itemCount: 1,
                                          shrinkWrap: true,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 50.0),
                        child: news.content == null
                            ? Column(
                                children: [
                                  const Text(
                                    'Error! This post has no description!',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Back to main screen'))
                                ],
                              )
                            : Text(
                                news.content,
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
