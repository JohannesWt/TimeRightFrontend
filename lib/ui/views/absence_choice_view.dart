import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/ui/shared/colors.dart';
import '../../app_localizations.dart';

class AbsenceChoiceView extends StatefulWidget {
  @override
  _AbsenceChoiceViewState createState() => _AbsenceChoiceViewState();
}

class _AbsenceChoiceViewState extends State<AbsenceChoiceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate('HOME_ABS_BTN_LABEL'),
          ),
        ),
        floatingActionButton: buildFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }



  Widget buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.pushNamed(context, RoutePaths.sickLeaveView),
      label: Text(
        AppLocalizations.of(context).translate('SICK_LEAVE'),
        style: TextStyle(fontSize: 20),
      ),
      icon: Icon(
        Icons.input,
        size: 24,
      ),
      backgroundColor: blueAccent,
    );
  }
}

