// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  return Employee(
      employeeID: json['employeeID'] as int,
      employeeLevel:
          _$enumDecodeNullable(_$EmployeeLevelEnumMap, json['employeeLevel']));
}

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'employeeID': instance.employeeID,
      'employeeLevel': _$EmployeeLevelEnumMap[instance.employeeLevel]
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

const _$EmployeeLevelEnumMap = <EmployeeLevel, dynamic>{
  EmployeeLevel.admin: 'admin',
  EmployeeLevel.executive: 'executive',
  EmployeeLevel.teamMember: 'teamMember'
};
