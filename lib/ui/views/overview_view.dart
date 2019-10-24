/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_right/core/models/contract_details/contract_details.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/ui/widgets/overview_cards.dart';

import '../../app_localizations.dart';

/// Class building the [OverviewView].
class OverviewView extends StatelessWidget {
  OverviewView({@required EmployeeDetails employeeDetails})
      : _employeeDetails = employeeDetails;

  /// [EmployeeDetails] to show the [CurrentWorkDetails] and [ContractDetails].
  final EmployeeDetails _employeeDetails;

  /// Build the overview with the [OverviewCards].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: OverviewCards(
              employeeDetails: _employeeDetails,
            ),
          ),
        ],
      ),
    );
  }

  /// Return the app bar with the title.
  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        AppLocalizations.of(context).translate('OVERVIEW_TITLE'),
      ),
    );
  }
}
