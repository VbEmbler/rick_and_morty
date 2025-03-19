import 'package:json_annotation/json_annotation.dart';

part 'origin_model.g.dart';

@JsonSerializable()
class OriginModel {
  String? name;
  String? url;

  OriginModel({this.name, this.url});

  factory OriginModel.fromJson(Map<String, dynamic> json) =>
      _$OriginModelFromJson(json);
}
