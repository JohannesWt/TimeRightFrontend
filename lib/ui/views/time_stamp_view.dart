/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/viewmodels/views/time_stamp_view_model.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/shared/stamp_fail_alerts.dart';
import 'package:time_right/ui/shared/string_formatter.dart';
import 'package:time_right/ui/views/base_widget.dart';

import '../../app_localizations.dart';

/// Class build the time stamp view.
class TimeStampView extends StatefulWidget {
  @override
  _TimeStampViewState createState() => _TimeStampViewState();
}

class _TimeStampViewState extends State<TimeStampView> {
  /// [TimeStampViewModel] handling the business logic for the [TimeStampView].
  TimeStampViewModel _timeStampViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TimeStampViewModel>(
      model: TimeStampViewModel(
          timeStampService: Provider.of(context),
          employeeDetailsService: Provider.of(context)),
      onModelReady: (model) => _timeStampViewModel = model,
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
                        left: MediaQuery.of(context).size.width * 0.2),
                    child: _buildChangeTypeButton(),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: _timeStampViewModel.currentSelected ==
                            TimeStampType.stampIn
                        ? _buildStampInForm()
                        : _buildStampOutForm(),
                  ),
                ],
              ),
            ),
            _buildButtonBar(),
          ],
        ),
      ),
    );
  }

  /// Return button to change from the stamp in to the stamp out form or the
  /// other way round.
  Widget _buildChangeTypeButton() {
    return Row(
      children: <Widget>[
        _getChangeButtonLabel(),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: Icon(Icons.autorenew),
            onPressed: () => _timeStampViewModel.changeTimeStampType(),
          ),
        )
      ],
    );
  }

  /// Return the right label (stamp in our out) for the change button.
  Widget _getChangeButtonLabel() {
    switch (_timeStampViewModel.currentSelected) {
      case TimeStampType.stampIn:
        return Text(
          AppLocalizations.of(context).translate('TIME_STAMP_VIEW_STAMP_IN'),
          style: Theme.of(context).textTheme.headline,
          textScaleFactor: 1.1,
        );
      case TimeStampType.stampOut:
        return Text(
          AppLocalizations.of(context).translate('TIME_STAMP_VIEW_STAMP_OUT'),
          style: Theme.of(context).textTheme.headline,
          textScaleFactor: 1.1,
        );
      default:
        return Text(AppLocalizations.of(context).translate('TIME_STAMP_VIEW_UNKNOWN'));
    }
  }

  /// Return the button bar in the bottom to submit a stamp or cancel it.
  Widget _buildButtonBar() {
    return ButtonBar(
      mainAxisSize: MainAxisSize.max,
      alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
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
              TimeStampResponse timeStampResponse = await _timeStampViewModel
                  .stamp(_timeStampViewModel.stampTime)
                  .catchError((error) {
                print('error');
              });
              _showResponseWidget(timeStampResponse);
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

  /// Show an alert if the [TimeStampResponse] includes an error.
  void _showResponseWidget(TimeStampResponse timeStampResponse) {
    switch (timeStampResponse) {
      case (TimeStampResponse.stampOutFirstFail):
        showDialog(
            context: context,
            builder: (context) {
              return StampOutFirstFailAlert();
            });
        _timeStampViewModel.changeTimeStampType();
        break;
      case (TimeStampResponse.stampInFirstFail):
        showDialog(
            context: context,
            builder: (context) {
              return StampInFirstFailAlert();
            });
        _timeStampViewModel.changeTimeStampType();
        break;
      case (TimeStampResponse.stampVacationFail):
        showDialog(
            context: context,
            builder: (context) {
              return StampVacationFailAlert();
            });
        break;
      case (TimeStampResponse.stampFlexDayFail):
        showDialog(
            context: context,
            builder: (context) {
              return StampFlexDayFailAlert();
            });
        break;
      case (TimeStampResponse.stampTypeFail):
        showDialog(
            context: context,
            builder: (context) => UnknownStampTypeFailAlert());
        break;
      case (TimeStampResponse.stampWorkDayFail):
        showDialog(context: context, builder: (context) => WorkDayFailAlert());
        break;
      default:
        Navigator.pushNamed(context, RoutePaths.homeView,
            arguments: _timeStampViewModel.employeeDetails);
    }
  }

  /// Return the stamp in form.
  Widget _buildStampInForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('TIME_STAMP_VIEW_STAMP_IN_AT'),
          style: Theme.of(context).textTheme.subhead,
          textScaleFactor: 1.1,
        ),
        Text(
          '${StringFormatter.getFormattedClockTimeString(_timeStampViewModel.stampTime)}',
          style: TextStyle(fontSize: 40),
        )
      ],
    );
  }

  /// Return the stamp out form
  Widget _buildStampOutForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('TIME_STAMP_VIEW_STAMP_OUT_AT'),
          style: Theme.of(context).textTheme.subhead,
          textScaleFactor: 1.1,
        ),
        Text(
          '${StringFormatter.getFormattedClockTimeString(_timeStampViewModel.stampTime)}',
          style: TextStyle(fontSize: 40),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            AppLocalizations.of(context).translate('TIME_STAMP_VIEW_STAMP_OUT_WORKED_HRS'),
            style: Theme.of(context).textTheme.subhead,
            textScaleFactor: 1.1,
          ),
        ),
        Text(
          '${StringFormatter.formatDuration(_timeStampViewModel.workHours)}',
          style: TextStyle(fontSize: 30),
        ),
      ],
    );
  }
}
