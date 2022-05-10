// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Articles _$ArticlesFromJson(Map<String, dynamic> json) => Articles(
      title: json['title'] as String,
      author: json['author'] as String,
      publishedDate: json['publishedDate'] as String,
      link: json['link'] as String,
      excerpt: json['excerpt'] as String,
      summary: json['summary'] as String,
      authors: json['authors'] as String,
      media: json['media'] as String,
      rights: json['rights'] as String,
    );

Map<String, dynamic> _$ArticlesToJson(Articles instance) => <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'publishedDate': instance.publishedDate,
      'link': instance.link,
      'excerpt': instance.excerpt,
      'summary': instance.summary,
      'authors': instance.authors,
      'media': instance.media,
      'rights': instance.rights,
    };
