import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';

class TimeStampsListModel extends BaseModel {
  TimeStampsListModel({EmployeeDetailsService employeeDetailsService})
      : _employeeDetailsService = employeeDetailsService;

  final EmployeeDetailsService _employeeDetailsService;

  int _mainIndex;

  int get mainIndex => _mainIndex;

  TimeStampDay _todayTimeStampDay;

  TimeStampDay get todayTimeStampDay => _todayTimeStampDay;

  TimeStampDay _currentTimeStampDay;

  set currentTimeStampDay(TimeStampDay value) {
    _currentTimeStampDay = value;
    notifyListeners();
  }

  TimeStampDay get currentTimeStampDay => _currentTimeStampDay;

  List<TimeStampDay> get timeStampsDayList =>
      _employeeDetailsService.employeeDetails.timeStampDetails;

  List<TimeStampEvent> get currentTimeStampEventList =>
      _currentTimeStampDay.timeStampEvents;

  void setTimeStampDay(DateTime compDate) {
    _todayTimeStampDay = _currentTimeStampDay =
        _employeeDetailsService.getTimeStampsForDay(compDate);
    notifyListeners();
  }

  void getPreviousTimeStampDay() {
    int index = timeStampsDayList.indexOf(_currentTimeStampDay);
    print('index ' + index.toString());
    if (index < timeStampsDayList.length - 1) {
      _currentTimeStampDay = timeStampsDayList[index + 1];
      notifyListeners();
    } else {
      print('Keine mehr niedrig');
    }
  }

  void getNextTimeStampDay() {
    int index = timeStampsDayList.indexOf(_currentTimeStampDay);
    print('index ' + index.toString());
    if (index > 0) {
      _currentTimeStampDay = timeStampsDayList[index - 1];
      notifyListeners();
    } else {
      print('Keine mehr hoch');
    }
  }
}
