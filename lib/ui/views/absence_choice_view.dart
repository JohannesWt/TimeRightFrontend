import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:time_right/core/constants/app_constants.dart';
import '../../app_localizations.dart';

class AbsenceChoiceView extends StatelessWidget {
  AbsenceChoiceView({@required DateTime dateTime}) : _dateTime = dateTime;

  final DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
                AppLocalizations.of(context).translate('ABSENCE_VIEW_TITLE'))),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButton(context, AppLocalizations.of(context).translate('ABSENCE_VIEW_VAC_BTN'), RoutePaths.vacationView,
                _dateTime),
            _buildButton(context, AppLocalizations.of(context).translate('ABSENCE_VIEW_FLEX_BTN'), RoutePaths.flexDayView,
                _dateTime),
            _buildButton(context, AppLocalizations.of(context).translate('ABSENCE_VIEW_SICK_BTN'), RoutePaths.sickDayView,
                _dateTime),
          ],
        ));
  }

  Widget _buildButton(
      BuildContext context, String label, String target, DateTime startDate) {
    double paddingLeftRight = 15;
    return Padding(
        padding: EdgeInsets.only(left: 5, right: 5, top: 12, bottom: 12),
        child: FlatButton(
            padding: EdgeInsets.only(
                left: paddingLeftRight,
                right: paddingLeftRight,
                top: 12.0,
                bottom: 12.0),
            onPressed: () =>
                Navigator.pushNamed(context, target, arguments: startDate),
            child: Row(
              children: <Widget>[
                Text("$label ", textScaleFactor: 1.4),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.arrow_forward_ios)))
              ],
            )));
  }
}
