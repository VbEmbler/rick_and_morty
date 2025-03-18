import 'package:json_annotation/json_annotation.dart';

part 'info_model.g.dart';

@JsonSerializable()
class InfoModel {
  int? count;
  int? pages;
  String? next;
  String? prev;

  InfoModel({this.count, this.pages, this.next, this.prev});

  factory InfoModel.fromJson(Map<String, dynamic> json) =>
      _$InfoModelFromJson(json);
}
