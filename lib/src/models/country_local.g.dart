// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_local.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      json['name'] as String,
      json['country'] as String,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'name': instance.name,
      'country': instance.country,
    };

CountryList _$CountryListFromJson(Map<String, dynamic> json) => CountryList(
      (json['countries'] as List<dynamic>)
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountryListToJson(CountryList instance) =>
    <String, dynamic>{
      'countries': instance.countries,
    };
