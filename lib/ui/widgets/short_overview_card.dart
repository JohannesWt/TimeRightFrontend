/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_right/app_localizations.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/ui/views/home_view.dart';

import 'work_time_clock.dart';

/// Class builds the short overview card on the [HomeView].
class ShortOverviewCard extends StatelessWidget {
  ShortOverviewCard({@required EmployeeDetails employeeDetails})
      : _employeeDetails = employeeDetails;

  /// [EmployeeDetails] to get access to all information for the overview.
  final EmployeeDetails _employeeDetails;

  /// Build short overview card.
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Provider.of<Employee>(context).employeeLevel ==
                    EmployeeLevel.teamMember
                ? Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: WorkTimeClock())
                : Container(),
            Expanded(
              child: _buildShortOverview(context),
            ),
          ],
        ),
      ),
    );
  }

  /// Return column with all information included in the short over view card.
  Widget _buildShortOverview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('HOME_CARD_TITLE'),
          style: Theme.of(context).textTheme.title,
        ),
        Table(
          columnWidths: {1: FractionColumnWidth(.25)},
          children: [
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('HOME_CARD_WORK_TIME')),
              Text(
                '${_employeeDetails.contractDetails.workHours / 5}',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(
                  AppLocalizations.of(context).translate('HOME_CARD_OVERTIME')),
              Text(
                '${_employeeDetails.currentWorkDetails.flexTime}',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(
                  AppLocalizations.of(context).translate('HOME_CARD_LEFT_VAC')),
              Text(
                '${_employeeDetails.contractDetails.vacation - _employeeDetails.currentWorkDetails.takenVacation - _employeeDetails.currentWorkDetails.appliedVacation}',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('HOME_CARD_SICK_DAYS')),
              Text(
                '${_employeeDetails.currentWorkDetails.sickDaysCurrentMonth}',
                textAlign: TextAlign.right,
              )
            ])
          ],
        ),
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, RoutePaths.overviewView,
              arguments: _employeeDetails),
          padding: const EdgeInsets.all(3.0),
          child: Row(
            children: <Widget>[
              Text(AppLocalizations.of(context)
                  .translate('HOME_CARD_OVERVIEW_BTN')),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward_ios)))
            ],
          ),
        ),
      ],
    );
  }
}
