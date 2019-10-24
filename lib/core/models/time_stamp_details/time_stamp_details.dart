/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:json_annotation/json_annotation.dart';

part 'time_stamp_details.g.dart';

/// Holds time stamp days employee for a day. By using the build_runner script
/// this class generates the time_stamp_details.g.dart file automatically which
/// is used to serialize the responded json data from the backend safely.
@JsonSerializable()
class TimeStampDay {
  TimeStampDay({this.date, this.timeStampEvents});

  factory TimeStampDay.fromJson(Map<String, dynamic> json) =>
      _$TimeStampDayFromJson(json);

  Map<String, dynamic> toJson() => _$TimeStampDayToJson(this);

  final DateTime date;
  List<TimeStampEvent> timeStampEvents;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeStampDay &&
          runtimeType == other.runtimeType &&
          date == other.date;

  @override
  int get hashCode => date.hashCode;
}

/// Holds detailed information of a single time stamp event.
@JsonSerializable()
class TimeStampEvent {
  TimeStampEvent({
    this.timeStampType,
    this.dateTime,
    this.employeeName,
  });

  factory TimeStampEvent.fromJson(Map<String, dynamic> json) =>
      _$TimeStampEventFromJson(json);

  Map<String, dynamic> toJson() => _$TimeStampEventToJson(this);

  final TimeStampType timeStampType;
  final DateTime dateTime;
  final String employeeName;
}

/// Defines different types of time stamps
enum TimeStampType {
  vacation,
  vacationValidation,
  vacationValidationFail,
  flexDay,
  flexDayValidation,
  flexDayValidationFail,
  stampIn,
  stampInFail,
  stampInValidation,
  stampInValidationFail,
  stampOut,
  stampOutFail,
  stampOutValidation,
  stampOutValidationFail,
  sickDay,
  sickDayValidation,
  sickDayValidationFail,
}

/// Defines different types of time stamp responses
enum TimeStampResponse {
  stampInSuccess,
  stampOutSuccess,
  stampOutForValidation,
  stampVacationSuccess,
  stampVacationFail,
  stampFlexDaySuccess,
  stampFlexDayFail,
  stampSickDaySuccess,
  stampSickDayFail,
  stampInFirstFail,
  stampOutFirstFail,
  stampWorkDayFail,
  unknownResult
}
