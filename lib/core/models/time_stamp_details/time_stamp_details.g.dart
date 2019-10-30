// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_stamp_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeStampDay _$TimeStampDayFromJson(Map<String, dynamic> json) {
  return TimeStampDay(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      timeStampEvents: (json['timeStampEvents'] as List)
          ?.map((e) => e == null
              ? null
              : TimeStampEvent.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$TimeStampDayToJson(TimeStampDay instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'timeStampEvents': instance.timeStampEvents
    };

TimeStampEvent _$TimeStampEventFromJson(Map<String, dynamic> json) {
  return TimeStampEvent(
      timeStampType:
          _$enumDecodeNullable(_$TimeStampTypeEnumMap, json['timeStampType']),
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      employeeID: json['employeeID'] as int,
      employeeName: json['employeeName'] as String);
}

Map<String, dynamic> _$TimeStampEventToJson(TimeStampEvent instance) {
  final val = <String, dynamic>{
    'timeStampType': _$TimeStampTypeEnumMap[instance.timeStampType],
    'dateTime': instance.dateTime?.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('employeeID', instance.employeeID);
  writeNotNull('employeeName', instance.employeeName);
  return val;
}

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
  TimeStampType.vacationValidation: 'vacationValidation',
  TimeStampType.vacationValidationFail: 'vacationValidationFail',
  TimeStampType.flexDay: 'flexDay',
  TimeStampType.flexDayValidation: 'flexDayValidation',
  TimeStampType.flexDayValidationFail: 'flexDayValidationFail',
  TimeStampType.stampIn: 'stampIn',
  TimeStampType.stampInFail: 'stampInFail',
  TimeStampType.stampInValidation: 'stampInValidation',
  TimeStampType.stampInValidationFail: 'stampInValidationFail',
  TimeStampType.stampOut: 'stampOut',
  TimeStampType.stampOutFail: 'stampOutFail',
  TimeStampType.stampOutValidation: 'stampOutValidation',
  TimeStampType.stampOutValidationFail: 'stampOutValidationFail',
  TimeStampType.sickDay: 'sickDay',
  TimeStampType.sickDayValidation: 'sickDayValidation',
  TimeStampType.sickDayValidationFail: 'sickDayValidationFail'
};
