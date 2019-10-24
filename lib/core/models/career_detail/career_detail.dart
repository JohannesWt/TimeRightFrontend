/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:json_annotation/json_annotation.dart';

part 'career_detail.g.dart';

/// Holds former career data of an employee. By using the build_runner script
/// this class generates the career_detail.g.dart file automatically which is
/// used to serialize the responded json data from the backend safely.
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
  DateTime startDate;
  DateTime endDate;
}
