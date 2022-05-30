import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class Articles {
  final String title;
  final String link;
  final List creator;
  final String description;
  final String content;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final DateTime pubDate;
  @JsonKey(name: 'source_id')
  final String sourceId;
  final List country;
  final List category;
  final String language;
  Articles(
      {required this.title,
      required this.link,
      required this.creator,
      required this.description,
      required this.content,
      required this.pubDate,
      required this.imageUrl,
      required this.sourceId,
      required this.country,
      required this.category,
      required this.language});

  factory Articles.fromJson(Map<String, dynamic> json) =>
      _$ArticlesFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesToJson(this);
}

// @JsonSerializable()
// class ArticlesResponse extends Equatable {
//   String status;
//   int totalResults;
//   @JsonKey(ignore: true)
//   dynamic error;

//   ArticlesResponse({required this.status, required this.totalResults});

//   factory ArticlesResponse.fromJson(Map<String, dynamic> json) =>
//       _$ArticlesResponseFromJson(json);

//   ArticlesResponse.withError({this.error});

//   @override
//   List<Object?> get props => [this.status, this.totalResults];
// }
