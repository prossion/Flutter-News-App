import 'package:json_annotation/json_annotation.dart';

part 'country_local.g.dart';

@JsonSerializable()
class Country {
  final String name;
  final String country;

  Country(this.name, this.country);

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}

@JsonSerializable()
class CountryList {
  final List<Country> countries;

  CountryList(this.countries);

  factory CountryList.fromJson(Map<String, dynamic> json) =>
      _$CountryListFromJson(json);
}

class LocalStorageData {
  final String countryFlag;

  LocalStorageData({required this.countryFlag});
}
