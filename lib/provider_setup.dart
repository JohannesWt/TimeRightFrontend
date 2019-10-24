/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:provider/provider.dart';
import 'package:time_right/core/services/authentication_service.dart';
import 'package:time_right/core/services/time_stamp_service.dart';
import 'package:time_right/core/services/employee_details_service.dart';

import 'core/models/employee/employee.dart';
import 'core/services/api.dart';

/// List of all available providers throughout the app.
List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

/// List of services which do not depend on another service.
List<SingleChildCloneableWidget> independentServices = [
  Provider.value(value: Api()),
];

/// List of services which do depend on another service.
List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<Api, AuthenticationService>(
    builder: (context, api, authenticationService) =>
        AuthenticationService(api: api),
  ),
  ProxyProvider<Api, EmployeeDetailsService>(
    builder: (context, api, employeeDetailsService) =>
        EmployeeDetailsService(api: api),
  ),
  ProxyProvider<Api, TimeStampService>(
    builder: (context, api, timeStampService) => TimeStampService(api: api),
  ),
];

/// List of services which provide ui consumable data, which is needed throughout
/// the app (e.g. the employeeID of the current logged in user)
List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<Employee>(
    builder: (context) =>
        Provider.of<AuthenticationService>(context, listen: false).employee,
  )
];
