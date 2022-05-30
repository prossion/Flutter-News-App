// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Articles _$ArticlesFromJson(Map<String, dynamic> json) => Articles(
      title: json['title'] as String,
      link: json['link'] as String,
      creator: json['creator'] as List<dynamic>,
      description: json['description'] as String,
      content: json['content'] as String,
      pubDate: DateTime.parse(json['pubDate'] as String),
      imageUrl: json['image_url'] as String,
      sourceId: json['source_id'] as String,
      country: json['country'] as List<dynamic>,
      category: json['category'] as List<dynamic>,
      language: json['language'] as String,
    );

Map<String, dynamic> _$ArticlesToJson(Articles instance) => <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'creator': instance.creator,
      'description': instance.description,
      'content': instance.content,
      'image_url': instance.imageUrl,
      'pubDate': instance.pubDate.toIso8601String(),
      'source_id': instance.sourceId,
      'country': instance.country,
      'category': instance.category,
      'language': instance.language,
    };
