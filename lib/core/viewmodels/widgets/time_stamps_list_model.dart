import 'package:flutter/cupertino.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';

class TimeStampsListModel extends BaseModel {
  TimeStampsListModel({@required TimeStampService timeStampService})
      : _timeStampService = timeStampService;

  final TimeStampService _timeStampService;

  List<TimeStampEvent> _currentTimeStampEventList;

  List<TimeStampEvent> get currentTimeStampEventList =>
      _currentTimeStampEventList;

  DateTime _currentTimeStampDay = DateTime.now();

  DateTime get currentTimeStampDay => _currentTimeStampDay;

  set currentTimeStampDay(DateTime newDateTime) {
    _currentTimeStampDay = newDateTime;
    setTimeStampEventList();
    notifyListeners();
  }

  void setTimeStampEventList() {
    _currentTimeStampEventList =
        _timeStampService.getTimeStampEventsForDay(_currentTimeStampDay);
    notifyListeners();
  }

  void setNextDay() {
    _currentTimeStampDay = _currentTimeStampDay.add(Duration(days: 1));
    setTimeStampEventList();
    notifyListeners();
  }

  void setPreviousDay() {
    _currentTimeStampDay = _currentTimeStampDay.subtract(Duration(days: 1));
    setTimeStampEventList();
    notifyListeners();
  }
}
