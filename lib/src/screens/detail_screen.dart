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
      body: Container(
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
                    image: news.media != null
                        ? NetworkImage(news.media)
                        : const AssetImage("assets/icons/icon_error.png")
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 330,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 30.0),
                        child: Text(
                          news.title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 5.0,
                                  bottom: 5.0),
                              child: Text(news.topic == null ? '' : news.topic,
                                  style: const TextStyle(fontSize: 15)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10.0, bottom: 50.0),
                        child: Text(
                          news.summary == null ? '' : news.summary,
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
