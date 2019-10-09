import 'dart:async';

import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/core/services/api.dart';

class AuthenticationService {
  AuthenticationService({Api api}) : _api = api;

  final Api _api;

  StreamController<Employee> _employeeController = StreamController<Employee>();

  Stream<Employee> get employee => _employeeController.stream;

  Future<Employee> login(String employeeID) async {
    var fetchedEmployee = await _api.fetchEmployee(employeeID);
    if (fetchedEmployee != null) {
      _employeeController.add(fetchedEmployee);
    }
    return fetchedEmployee;
  }
}
