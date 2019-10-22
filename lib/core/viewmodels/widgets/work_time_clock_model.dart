import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';
import 'package:time_right/ui/shared/string_formatter.dart';

class WorkTimeClockModel extends BaseModel {
  WorkTimeClockModel(
      {@required EmployeeDetailsService employeeDetailsService,
      @required TimeStampService timeStampService})
      : _employeeDetailsService = employeeDetailsService,
        _timeStampService = timeStampService;

  final EmployeeDetailsService _employeeDetailsService;
  final TimeStampService _timeStampService;

  Timer _workTimer;

  Timer get workTimer => _workTimer;

  @override
  void dispose() {
    _workTimer.cancel();
    super.dispose();
  }

  void startWorkTimer() async {
    _getWorkHours();
    // TODO: Comment in timer
    _workTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _getWorkHours();
    });
  }

  void _getWorkHours() {
    Duration workHours = _timeStampService.calculateWorkHour(DateTime.now());
    _workHoursString = StringFormatter.formatDuration(workHours);
    _percentage = (workHours.inSeconds /
        _employeeDetailsService.getContractWorkHours().inSeconds);
    print('Workhours: $_workHoursString');
    notifyListeners();
  }

  String _workHoursString = '00.00:00';

  String get workHoursString => _workHoursString;

  double _percentage = 0;

  double get percentage => _percentage;
}
