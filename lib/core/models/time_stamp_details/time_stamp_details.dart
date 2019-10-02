import 'package:json_annotation/json_annotation.dart';

part 'time_stamp_details.g.dart';

@JsonSerializable()
class TimeStampDay {
  TimeStampDay({this.date, this.timeStampEvents});

  factory TimeStampDay.fromJson(Map<String, dynamic> json) =>
      _$TimeStampDayFromJson(json);

  Map<String, dynamic> toJson() => _$TimeStampDayToJson(this);

  final String date;
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

@JsonSerializable()
class TimeStampEvent {
  TimeStampEvent({
    this.timeStampType,
    this.dateTime,
  });

  factory TimeStampEvent.fromJson(Map<String, dynamic> json) =>
      _$TimeStampEventFromJson(json);

  Map<String, dynamic> toJson() => _$TimeStampEventToJson(this);

  final TimeStampType timeStampType;
  final String dateTime;
}

enum TimeStampType { vacation, overTimeDay, stampIn, stampOut, sickDay }