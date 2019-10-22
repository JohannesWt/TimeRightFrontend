import 'package:time_right/core/models/contract_details/contract_details.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/core/services/employee_details_service.dart';
import 'package:time_right/core/viewmodels/base_model.dart';

class ShortOverviewCardModel extends BaseModel {
  ShortOverviewCardModel({EmployeeDetailsService employeeDetailsService})
      : _employeeDetailService = employeeDetailsService;

  final EmployeeDetailsService _employeeDetailService;

  EmployeeDetails get employeeDetails => _employeeDetailService.employeeDetails;

  CurrentWorkDetails get currentWorkDetails =>
      _employeeDetailService.employeeDetails.currentWorkDetails;

  ContractDetails get contractDetails =>
      _employeeDetailService.employeeDetails.contractDetails;
}
