import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class Articles {
  final String title;
  final String author;
  final String publishedDate;
  final String link;
  final String excerpt;
  final String topic;
  final String summary;
  final String media;
  final String rights;

  Articles({
    required this.title,
    required this.author,
    required this.publishedDate,
    required this.link,
    required this.excerpt,
    required this.topic,
    required this.summary,
    required this.media,
    required this.rights,
  });

  factory Articles.fromJson(Map<String, dynamic> json) =>
      _$ArticlesFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesToJson(this);
}
