/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:time_right/app_localizations.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/models/contract_details/contract_details.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/ui/views/overview_view.dart';

/// Class builds the single cards in the [OverviewView].
class OverviewCards extends StatelessWidget {
  OverviewCards({@required EmployeeDetails employeeDetails})
      : _employeeDetails = employeeDetails;

  /// [EmployeeDetails] to display the [CurrentWorkDetails] and [ContractDetails].
  final EmployeeDetails _employeeDetails;

  /// Build the list of cards.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        //how do I call a list of widgets here?
                        child: _buildFlexTimeAccount(context)
                        // buildVacationAccount(),   buildOtherAbsences()
                        )),
              ],
            ),
          ),
        ),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        //how do I call a list of widgets here?
                        child: _buildVacationAccount(context)
                        // buildVacationAccount(),   buildOtherAbsences()
                        )),
              ],
            ),
          ),
        ),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: _buildOtherAbsences(context))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Return column with all flex time information
  Widget _buildFlexTimeAccount(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('OVERVIEW_CARD1_TITLE'),
          style: Theme.of(context).textTheme.title,
        ),
        Table(
          columnWidths: {1: FractionColumnWidth(.25)},
          children: [
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD1_OVER_HOURS')),
              Text(
                '${_employeeDetails.currentWorkDetails.flexTime}',
                textAlign: TextAlign.right,
              )
            ]),
//            TableRow(children:
//              Text(AppLocalizations.of(context)
//                  .translate('OVERVIEW_CARD1_SHORT_TERM_ACCOUNT')),
//              Text(
//                '8,5h',
//                textAlign: TextAlign.right,
//              )
//            ]),
//            TableRow(children: [
//              Text(AppLocalizations.of(context)
//                  .translate('OVERVIEW_CARD1_LONG_TERM_ACCOUNT')),
//              Text(
//                '12',
//                textAlign: TextAlign.right,
//              )
//            ]),
//            TableRow(children: [
//              Text(AppLocalizations.of(context)
//                  .translate('OVERVIEW_CARD1_OVERTIME_PREV_YEAR')),
//              Text(
//                '0',
//                textAlign: TextAlign.right,
//              )
//            ])
          ],
        ),
        FlatButton(
          onPressed: () =>
              Navigator.pushNamed(context, RoutePaths.overviewView),
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: <Widget>[
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD1_APPLY_FLEXTIME_BTN')),
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

  /// Return column with all vacation information
  Widget _buildVacationAccount(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('OVERVIEW_CARD2_TITLE'),
          style: Theme.of(context).textTheme.title,
        ),
        Table(
          columnWidths: {1: FractionColumnWidth(.25)},
          children: [
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD2_VAC_DAYS_CLAIM')),
              Text(
                '${_employeeDetails.contractDetails.vacation}',
                textAlign: TextAlign.right,
              )
            ]),
//            TableRow(children: [
//              Text(AppLocalizations.of(context)
//                  .translate('OVERVIEW_CARD2_VAC_DAYS_PREV_YEAR')),
//              Text(
//                '${widget._employeeDetails.currentWorkDetails.remainingVacationLastYear}',
//                textAlign: TextAlign.right,
//              )
//            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD2_VAC_TAKEN')),
              Text(
                '${_employeeDetails.currentWorkDetails.takenVacation}',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD2_VAC_APPLIED')),
              Text(
                '${_employeeDetails.currentWorkDetails.appliedVacation}',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD2_VAC_PLAN')),
              Text(
                '${_employeeDetails.contractDetails.vacation - _employeeDetails.currentWorkDetails.takenVacation}',
                textAlign: TextAlign.right,
              )
            ])
          ],
        ),
        FlatButton(
          onPressed: () =>
              Navigator.pushNamed(context, RoutePaths.overviewView),
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: <Widget>[
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD2_VAC_APPLY_BTN')),
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

  /// Return column with information of other absences.
  Widget _buildOtherAbsences(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('OVERVIEW_CARD3_TITLE'),
          style: Theme.of(context).textTheme.title,
        ),
        Table(
          columnWidths: {1: FractionColumnWidth(.25)},
          children: [
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD3_SICK_DAYS')),
              Text(
                '${_employeeDetails.currentWorkDetails.sickDaysCurrentMonth}',
                textAlign: TextAlign.right,
              )
            ]),
          ],
        ),
      ],
    );
  }
}
