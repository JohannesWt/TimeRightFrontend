import 'package:provider/provider.dart';
import 'package:time_right/core/services/authentication_service.dart';
import 'package:time_right/core/services/calendar_service.dart';
import 'package:time_right/core/services/employee_details_service.dart';

import 'core/models/employee/employee.dart';
import 'core/services/api.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(value: Api()),
];

List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<Api, AuthenticationService>(
    builder: (context, api, authenticationService) =>
        AuthenticationService(api: api),
  ),
  ProxyProvider<Api, EmployeeDetailsService>(
    builder: (context, api, employeeDetailsService) =>
        EmployeeDetailsService(api: api),
  ),
  ProxyProvider<Api, CalendarService>(
    builder: (context, api, calendarService) => CalendarService(api: api),
  ),
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<Employee>(
    builder: (context) =>
        Provider.of<AuthenticationService>(context, listen: false).employee,
  )
];
