import 'package:flutter/cupertino.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  HomeViewModel({@required EmployeeDetailsService employeeDetailsService})
      : _employeeDetailsService = employeeDetailsService;

  final EmployeeDetailsService _employeeDetailsService;

  EmployeeDetails get employeeDetails =>
      _employeeDetailsService.employeeDetails;

}
