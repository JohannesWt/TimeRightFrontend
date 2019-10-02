import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';

class WorkTimeClockModel extends BaseModel {
  WorkTimeClockModel({EmployeeDetailsService employeeDetailsService})
      : _employeeDetailsService = employeeDetailsService;

  final EmployeeDetailsService _employeeDetailsService;

  double _percentage = 70;

  double get percentage => _percentage;


}
