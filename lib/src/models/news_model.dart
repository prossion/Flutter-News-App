import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class Articles {
  final String title;
  final String author;
  final String publishedDate;
  final String link;
  final String excerpt;
  final String summary;
  final String authors;
  final String media;
  final String rights;

  Articles({
    required this.title,
    required this.author,
    required this.publishedDate,
    required this.link,
    required this.excerpt,
    required this.summary,
    required this.authors,
    required this.media,
    required this.rights,
  });
}
