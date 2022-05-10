// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Articles _$ArticlesFromJson(Map<String, dynamic> json) => Articles(
      title: json['title'] as String,
      author: json['author'] as String,
      publishedDate: json['published_date'] as String,
      link: json['link'] as String,
      excerpt: json['excerpt'] as String,
      topic: json['topic'] as String,
      summary: json['summary'] as String,
      media: json['media'] as String,
      rights: json['rights'] as String,
    );

Map<String, dynamic> _$ArticlesToJson(Articles instance) => <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'published_date': instance.publishedDate,
      'link': instance.link,
      'excerpt': instance.excerpt,
      'topic': instance.topic,
      'summary': instance.summary,
      'media': instance.media,
      'rights': instance.rights,
    };
