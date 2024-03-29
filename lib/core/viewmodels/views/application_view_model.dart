/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';

class ApplicationViewModel extends BaseModel {
  ApplicationViewModel({@required TimeStampService timeStampService})
      : _timeStampService = timeStampService;

  final TimeStampService _timeStampService;

  void setLists() {
    List<TimeStampEvent> tmpList = _timeStampService.executiveApplicationList;
    tmpList.forEach((event) => {
          if (event.timeStampType == TimeStampType.vacationValidation)
            {_vacationApplicationsList.add(event)}
          else if (event.timeStampType == TimeStampType.flexDayValidation)
            {_flexDayApplicationList.add(event)}
          else
            {_timeStampApplicationList.add(event)}
        });
  }

  List<TimeStampEvent> _vacationApplicationsList = [];

  List<TimeStampEvent> get vacationApplicationsList =>
      _vacationApplicationsList;

  TimeStampService get timeStampService => _timeStampService;

  List<TimeStampEvent> _flexDayApplicationList = [];

  List<TimeStampEvent> get flexDayApplicationList => _flexDayApplicationList;

  List<TimeStampEvent> _timeStampApplicationList = [];

  List<TimeStampEvent> get timeStampApplicationList =>
      _timeStampApplicationList;

  Future proveApplication(TimeStampEvent timeStampEvent, String action) async {
    await _timeStampService.proveStamp(timeStampEvent, action);
    if (timeStampEvent.timeStampType == TimeStampType.vacationValidation) {
      removeVacationApplication(timeStampEvent);
    } else if (timeStampEvent.timeStampType ==
        TimeStampType.flexDayValidation) {
      removeFlexDayApplication(timeStampEvent);
    } else {
      removeStampApplication(timeStampEvent);
    }
  }

  void removeVacationApplication(TimeStampEvent timeStampEvent) {
    _vacationApplicationsList.remove(timeStampEvent);
    notifyListeners();
  }

  void removeFlexDayApplication(TimeStampEvent timeStampEvent) {
    _flexDayApplicationList.remove(timeStampEvent);
    notifyListeners();
  }

  void removeStampApplication(TimeStampEvent timeStampEvent) {
    _timeStampApplicationList.remove(timeStampEvent);
    notifyListeners();
  }

  int getIndexOfItem(TimeStampEvent timeStampEvent) {
    TimeStampType timeStampType = timeStampEvent.timeStampType;
    if (timeStampType == TimeStampType.flexDayValidation) {
      return _flexDayApplicationList.indexOf(timeStampEvent);
    } else if (timeStampType == TimeStampType.vacationValidation) {
      return _vacationApplicationsList.indexOf(timeStampEvent);
    } else {
      return _timeStampApplicationList.indexOf(timeStampEvent);
    }
  }
}
