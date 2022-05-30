import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CategoryModel {
  String image;
  String title;

  CategoryModel(this.image, this.title);
}
