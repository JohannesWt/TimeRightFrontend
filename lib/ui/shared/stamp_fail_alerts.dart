/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_right/app_localizations.dart';

/// Show alert if the employee has to stamp out first, when the employee wanted
/// to stamp in but is still stamped in.
class StampOutFirstFailAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          AppLocalizations.of(context).translate('STAMP_FAIL_ALERT_TITLE')),
      content: Text(AppLocalizations.of(context)
          .translate('STAMP_OUT_FIRST_ALERT_CONTENT')),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).translate('STAMP_FAIL_ALERT_CONFIRM_BTN_LABEL')),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}

/// Show alert if the employee has to stamp in first, when the employee wanted
/// to stamp out but is already stamped out.
class StampInFirstFailAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text( AppLocalizations.of(context).translate('STAMP_FAIL_ALERT_TITLE')),
      content: Text(AppLocalizations.of(context).translate('STAMP_IN_FIRST_ALERT_CONTENT')),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).translate('STAMP_FAIL_ALERT_CONFIRM_BTN_LABEL')),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}

/// Show alert if the employee is not allowed to stamp any event, in order there
/// is a vacation already stamped in.
class StampVacationFailAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text( AppLocalizations.of(context).translate('STAMP_FAIL_ALERT_TITLE')),
      content: Text(AppLocalizations.of(context).translate('STAMP_VACATION_ALERT_CONTENT')),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).translate('STAMP_FAIL_ALERT_CONFIRM_BTN_LABEL')),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}

/// Show alert if the employee is not allowed to stamp any event, in order there
/// is a flex day already stamped in.
class StampFlexDayFailAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text( AppLocalizations.of(context).translate('STAMP_FAIL_ALERT_TITLE')),
      content: Text(AppLocalizations.of(context).translate('STAMP_FLEXDAY_ALERT_CONTENT')),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).translate('STAMP_FAIL_ALERT_CONFIRM_BTN_LABEL')),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}

/// Show alert for unknown errors
class UnknownStampTypeFailAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text( AppLocalizations.of(context).translate('STAMP_FAIL_ALERT_TITLE')),
      content: Text(AppLocalizations.of(context).translate('STAMP_UNKNOWN_ALERT_CONTENT')),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).translate('STAMP_FAIL_ALERT_CONFIRM_BTN_LABEL')),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}

/// Show alert for unknown errors
class WorkDayFailAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text( AppLocalizations.of(context).translate('STAMP_FAIL_ALERT_TITLE')),
      content: Text(AppLocalizations.of(context).translate('STAMP_WORKDAY_ALERT_CONTENT')),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).translate('STAMP_FAIL_ALERT_CONFIRM_BTN_LABEL')),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}
