import 'package:json_annotation/json_annotation.dart';

part 'career_detail.g.dart';

@JsonSerializable()
class CareerDetail {
  CareerDetail({
    this.companyName,
    this.department,
    this.workArea,
    this.startDate,
    this.endDate,
  });

  factory CareerDetail.fromJson(Map<String, dynamic> json) =>
      _$CareerDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CareerDetailToJson(this);

  String companyName;
  String department;
  String workArea;
  String startDate;
  String endDate;
}
