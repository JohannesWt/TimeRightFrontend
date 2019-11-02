/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/viewmodels/views/sick_day_view_model.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/shared/date_calculator.dart';
import 'package:time_right/ui/shared/string_formatter.dart';
import 'package:time_right/ui/views/base_widget.dart';

import '../../app_localizations.dart';

class SickDayView extends StatefulWidget {
  SickDayView({@required DateTime initialDate}) : _initialDate = initialDate;

  final DateTime _initialDate;

  @override
  _SickDayViewState createState() => _SickDayViewState();
}

class _SickDayViewState extends State<SickDayView> {
  /// Model which handles the business logic of [SickDayView].
  SickDayViewModel _sickDayViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SickDayViewModel>(
      child: AppBar(),
      model: SickDayViewModel(
          employeeDetailsService: Provider.of(context),
          timeStampService: Provider.of(context),
          initialDate: widget._initialDate),
      onModelReady: (model) => _sickDayViewModel = model,
      builder: (context, model, child) => Scaffold(
        appBar: child,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 30.0,
                        left: MediaQuery.of(context).size.width * 0.2),
                    child: Text(
                      AppLocalizations.of(context).translate('SICK_DAY_VIEW_FORM_TITLE'),
                      style: Theme.of(context).textTheme.headline,
                      textScaleFactor: 1.1,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: _buildSickDayForm(),
                  )
                ],
              ),
            ),
            _buildButtonBar(),
          ],
        ),
      ),
    );
  }

  /// Build sick day form where the employee can change the sick day date.
  Widget _buildSickDayForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('SICK_DAY_VIEW_FORM_DATE'),
          style: Theme.of(context).textTheme.subhead,
          textScaleFactor: 1.1,
        ),
        FlatButton.icon(
          onPressed: () => {_setNewSickDay()},
          icon: Icon(Icons.calendar_today),
          label: Text(
            '${StringFormatter.getFormattedShortDateString(_sickDayViewModel.sickDayDate)}',
            style: Theme.of(context).textTheme.headline,
          ),
        ),
      ],
    );
  }

  /// Set a new sick day date in [_sickDayViewModel].
  Future _setNewSickDay() async {
    final DateTime newDate = await showDatePicker(
        context: context,
        initialDate: _sickDayViewModel.sickDayDate,
        firstDate: _sickDayViewModel.sickDayDate.subtract(Duration(days: 365)),
        lastDate: _sickDayViewModel.sickDayDate.add(Duration(days: 365)));
    if (newDate != null)
//    &&
//        (newDate.isAfter(DateTime.now()) ||
//            DateCalculator.isOnSameDay(newDate, DateTime.now())))
    {
      _sickDayViewModel.sickDayDate = newDate;
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Fehler'),
              content: Text('Fehler beim Speichern des Kranktags.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            );
          });
    }
  }

  /// Build  button bar with the cancel and confirm button.
  Widget _buildButtonBar() {
    return ButtonBar(
      mainAxisSize: MainAxisSize.max,
      alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
              print(' Cancel Button was pressed');
            },
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.cancel,
                  color: red1,
                  size: 40,
                ),
                Text(
                  AppLocalizations.of(context).translate('CANCEL'),
                  style: Theme.of(context).textTheme.button,
                  textScaleFactor: 1.2,
                ),
              ],
            )),
        FlatButton(
            onPressed: () async {
              await _sickDayViewModel.stampSickDay().then((value) {
                Navigator.pushNamed(context, RoutePaths.homeView,
                    arguments: _sickDayViewModel.employeeDetails);
              });
            },
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: green1,
                  size: 40,
                ),
                Text(
                  AppLocalizations.of(context).translate('CONFIRM'),
                  style: Theme.of(context).textTheme.button,
                  textScaleFactor: 1.2,
                ),
              ],
            )),
      ],
    );
  }
}
