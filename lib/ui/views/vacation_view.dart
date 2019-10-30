/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/viewmodels/views/vacation_view_model.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/shared/date_calculator.dart';
import 'package:time_right/ui/shared/string_formatter.dart';
import 'package:time_right/ui/views/base_widget.dart';

import '../../app_localizations.dart';

class VacationView extends StatefulWidget {
  VacationView({@required DateTime startDate}) : _startDate = startDate;

  final DateTime _startDate;

  @override
  _VacationViewState createState() => _VacationViewState();
}

class _VacationViewState extends State<VacationView> {
  /// Model which handles the business logic of the [VacationView].
  VacationViewModel _vacationViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<VacationViewModel>(
      model: VacationViewModel(
          employeeDetailsService: Provider.of(context),
          timeStampService: Provider.of(context),
          startDate: widget._startDate),
      onModelReady: (model) => _vacationViewModel = model,
      child: AppBar(),
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
                      left: MediaQuery.of(context).size.width * 0.15,
                    ),
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('OVERVIEW_CARD2_VAC_APPLY_BTN'),
                      style: Theme.of(context).textTheme.headline,
                      textScaleFactor: 1.1,
                    ),
                  ),
                  Align(
                      alignment: Alignment.center, child: _buildVacationForm()),
                ],
              ),
            ),
            _buildButtonBar(),
          ],
        ),
      ),
    );
  }

  /// Build vacation form where the employee can change the vacation dates
  Widget _buildVacationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildStartDateForm(),
        _buildEndDateForm(),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('VAC_DAYS_SUM'),
                style: Theme.of(context).textTheme.subhead,
                textScaleFactor: 1.1,
              ),
              Text(
                '${_vacationViewModel.selectedDaysSum.inDays} days',
                style: Theme.of(context).textTheme.headline,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('VAC_DAYS_REMAINING'),
                style: Theme.of(context).textTheme.subhead,
                textScaleFactor: 1.1,
              ),
              Text(
                '${_vacationViewModel.remainingVacation} days',
                style: Theme.of(context).textTheme.headline,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build form where the employee can change the start date.
  Widget _buildStartDateForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('VAC_FROM'),
          style: Theme.of(context).textTheme.subhead,
          textScaleFactor: 1.1,
        ),
        FlatButton.icon(
          onPressed: () async => await _selectNewStartDate(),
          icon: Icon(Icons.calendar_today),
          label: Text(
            '${StringFormatter.getFormattedShortDateString(_vacationViewModel.startDate)}',
            style: Theme.of(context).textTheme.headline,
            textScaleFactor: 1.1,
          ),
        ),
      ],
    );
  }

  /// Select a new start date in [_vacationViewModel].
  Future _selectNewStartDate() async {
    final DateTime newStartDate = await showDatePicker(
      context: context,
      initialDate: _vacationViewModel.startDate,
      firstDate: _vacationViewModel.startDate.subtract(Duration(days: 365)),
      lastDate: _vacationViewModel.startDate.add(Duration(days: 365)),
    );
    if (newStartDate != null && newStartDate.isAfter(DateTime.now())) {
      _vacationViewModel.startDate = newStartDate;
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Fehler'),
              content: Text('Das neue Datum muss nach heutigem liegen.'),
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

  /// Build form where the employee can change the end date.
  Widget _buildEndDateForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('VAC_TO'),
          style: Theme.of(context).textTheme.subhead,
          textScaleFactor: 1.1,
        ),
        FlatButton.icon(
          onPressed: () async {
            await _selectNewEndDate();
          },
          icon: Icon(Icons.calendar_today),
          label: Text(
            '${StringFormatter.getFormattedShortDateString(_vacationViewModel.endDate)}',
            style: Theme.of(context).textTheme.headline,
            textScaleFactor: 1.1,
          ),
        ),
      ],
    );
  }

  ///  Select a new end date in [_vacationViewModel].
  Future _selectNewEndDate() async {
    final DateTime newEndDate = await showDatePicker(
        context: context,
        initialDate: _vacationViewModel.endDate,
        firstDate: _vacationViewModel.endDate.subtract(Duration(days: 365)),
        lastDate: _vacationViewModel.endDate.add(Duration(days: 365)));
    if (newEndDate != null &&
        (newEndDate.isAfter(_vacationViewModel.startDate) ||
            DateCalculator.isOnSameDay(
                newEndDate, _vacationViewModel.startDate))) {
      _vacationViewModel.endDate = newEndDate;
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Fehler'),
              content: Text(
                  'Das neue Datum muss größer gleich das Startdatum sein.'),
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

  /// Build button bar with confirm and cancel button.
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
//              Navigator.pop(context);
              await _vacationViewModel.stampVacation().then((value) {
                Navigator.pushNamed(context, RoutePaths.homeView,
                    arguments: _vacationViewModel.employeeDetails);
                print('Confirm Button was pressed');
              }).catchError((error) {

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
