import 'package:flutter/cupertino.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';

class TimeStampViewModel extends BaseModel {
  TimeStampViewModel(
      {@required TimeStampService timeStampService,
      EmployeeDetailsService employeeDetailsService})
      : _timeStampService = timeStampService,
        _employeeDetailsService = employeeDetailsService;

  TimeStampService _timeStampService;
  EmployeeDetailsService _employeeDetailsService;

  List<TimeStampType> _dropDownList = [
    TimeStampType.stampIn,
    TimeStampType.stampOut
  ];

  Future<TimeStampResponse> stampIn(DateTime dateTime) async {
    TimeStampResponse timeStampResponse = await _timeStampService.stampIn(dateTime);
  }
}
