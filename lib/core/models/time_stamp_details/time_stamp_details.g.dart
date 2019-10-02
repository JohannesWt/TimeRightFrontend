// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_stamp_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeStampDay _$TimeStampDayFromJson(Map<String, dynamic> json) {
  return TimeStampDay(
      date: json['date'] as String,
      timeStampEvents: (json['timeStampEvents'] as List)
          ?.map((e) => e == null
              ? null
              : TimeStampEvent.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$TimeStampDayToJson(TimeStampDay instance) =>
    <String, dynamic>{
      'date': instance.date,
      'timeStampEvents': instance.timeStampEvents
    };

TimeStampEvent _$TimeStampEventFromJson(Map<String, dynamic> json) {
  return TimeStampEvent(
      timeStampType:
          _$enumDecodeNullable(_$TimeStampTypeEnumMap, json['timeStampType']),
      dateTime: json['dateTime'] as String);
}

Map<String, dynamic> _$TimeStampEventToJson(TimeStampEvent instance) =>
    <String, dynamic>{
      'timeStampType': _$TimeStampTypeEnumMap[instance.timeStampType],
      'dateTime': instance.dateTime
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$TimeStampTypeEnumMap = <TimeStampType, dynamic>{
  TimeStampType.vacation: 'vacation',
  TimeStampType.overTimeDay: 'overTimeDay',
  TimeStampType.stampIn: 'stampIn',
  TimeStampType.stampOut: 'stampOut'
};
