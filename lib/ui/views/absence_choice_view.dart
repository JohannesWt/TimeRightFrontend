import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:time_right/core/constants/app_constants.dart';
import '../../app_localizations.dart';

class AbsenceChoiceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
                AppLocalizations.of(context).translate('HOME_ABS_BTN_LABEL'))),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButton(context, "Urlaub beantragen", RoutePaths.vacationView),
            _buildButton(context, "Gleittag beantragen", RoutePaths.flexDayView),
            _buildButton(context, "Krankmeldung", RoutePaths.sickDayView),
          ],
        ));
  }

  Widget _buildButton(BuildContext context, String label, String target) {
    double paddingLeftRight = 15;
    double paddingBottomTop = 20;
    return Padding(
        padding: EdgeInsets.only(
            left: paddingLeftRight,
            right: paddingLeftRight,
            top: paddingBottomTop,
            bottom: paddingBottomTop),
        child: FlatButton(
            onPressed: () => Navigator.pushNamed(context, target),
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
