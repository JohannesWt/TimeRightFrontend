/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/core/models/employee_details/employee_details.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/views/absence_choice_view.dart';
import 'package:time_right/ui/views/calendar_view.dart';
import 'package:time_right/ui/views/profile_view.dart';
import 'package:time_right/ui/views/time_stamp_view.dart';
import 'package:time_right/ui/widgets/short_overview_card.dart';
import 'package:time_right/ui/widgets/time_stamps_list.dart';

import '../../app_localizations.dart';

/// Class  building the home view
class HomeView extends StatelessWidget {
  HomeView({@required EmployeeDetails employeeDetails})
      : _employeeDetails = employeeDetails;

  /// Reference to [EmployeeDetails] to pass it to [ShortOverviewCard] and
  /// get the amount of time stamp fails.
  final EmployeeDetails _employeeDetails;

  /// Build the home view with the Card, including the work timer and the short
  /// overview.
  /// Beneath that the two action buttons and under that the displayed time stamps
  /// list.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ShortOverviewCard(employeeDetails: _employeeDetails,),
            ),
            _buildMenuButtons(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: TimeStampsList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// Return the app bar with the title and the action button leading to the
  /// [ProfileView].
  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        AppLocalizations.of(context).translate('HOME_TITLE') + '\u{00AE}',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.person,
            color: gray4,
          ),
          onPressed: () => Navigator.pushNamed(context, RoutePaths.profileView),
        )
      ],
    );
  }

  /// Return the floating action button leading to the [TimeStampView].
  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.pushNamed(context, RoutePaths.timeStampView),
      label: Text(
        AppLocalizations.of(context).translate('HOME_FAB_LABEL'),
        style: TextStyle(fontSize: 20),
      ),
      icon: Icon(
        Icons.input,
        size: 24,
      ),
      backgroundColor: blueAccent,
    );
  }

  /// Return the both menu buttons leading to [CalendarView] with the notification
  /// batch showing stamp fails and leading to [AbsenceChoiceView].
  Widget _buildMenuButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 5, right: 5),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildMenuButton(
                context,
                AppLocalizations.of(context).translate('HOME_CAL_BTN_LABEL'),
                Icons.calendar_today,
                true,
                RoutePaths.calendarView),
            VerticalDivider(
              color: gray4,
              width: 20,
              thickness: 1.2,
            ),
            _buildMenuButton(
                context,
                AppLocalizations.of(context).translate('HOME_ABS_BTN_LABEL'),
                Icons.add,
                false,
                RoutePaths.absenceChoiceView),
          ],
        ),
      ),
    );
  }

  /// Return one menu button for [_buildMenuButtons].
  Widget _buildMenuButton(BuildContext context, String title, IconData icon,
      bool notificationBatch, String target) {
    return Expanded(
      child: FlatButton(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
          ),
          child: Column(
            children: <Widget>[
              !notificationBatch
                  ? Icon(
                      icon,
                      size: 26,
                    )
                  : Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Icon(
                          icon,
                          size: 26,
                        ),
                        Positioned(
                          right: 0,
                          top: 1,
                          child: _employeeDetails.stampFailsSum > 0
                              ? Container(
                                  padding: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                      color: mainRed,
                                      borderRadius: BorderRadius.circular(6.0)),
                                  constraints: BoxConstraints(
                                      minWidth: 14, minHeight: 14),
                                  child: Text(
                                    '${_employeeDetails.stampFailsSum}',
                                    style: TextStyle(fontSize: 8, color: white),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
              Text(
                title,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, target),
      ),
    );
  }
}
