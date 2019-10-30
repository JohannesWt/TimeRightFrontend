/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/viewmodels/views/correct_stamp_view_model.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/views/base_widget.dart';

import '../../app_localizations.dart';

class CorrectStampView extends StatefulWidget {
  CorrectStampView(
      {@required DateTime initialDate,
      @required TimeStampType initialStampType})
      : _initialDate = initialDate,
        _initialStampType = initialStampType;

  final DateTime _initialDate;
  final TimeStampType _initialStampType;

  @override
  _CorrectStampViewState createState() => _CorrectStampViewState();
}

class _CorrectStampViewState extends State<CorrectStampView> {
  /// Handles business logic of [CorrectStampView].
  CorrectStampViewModel _correctStampViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CorrectStampViewModel>(
      child: AppBar(),
      model: CorrectStampViewModel(
          employeeDetailsService: Provider.of(context),
          timeStampService: Provider.of(context),
          timeStampType: widget._initialStampType,
          correctStampDate: widget._initialDate),
      onModelReady: (model) => _correctStampViewModel = model,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Nachtragen',
                          style: Theme.of(context).textTheme.subhead,
                          textScaleFactor: 1.1,
                        ),
                        _buildChangeTypeButton(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: _buildCorrectStampForm(),
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
            onPressed: () => _correctStampViewModel.changeTimeStampType(),
          ),
        )
      ],
    );
  }

  /// Return form to put in correct time stamp data.
  Widget _buildCorrectStampForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Datum:',
              style: Theme.of(context).textTheme.subhead,
            ),
            FlatButton.icon(
                onPressed: () => _setNewCorrectStampDate(),
                icon: Icon(Icons.calendar_today),
                label: Text(
                  '${_correctStampViewModel.correctStampDateString}',
                  style: Theme.of(context).textTheme.headline,
                )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Uhrzeit:',
                style: Theme.of(context).textTheme.subhead,
              ),
              FlatButton.icon(
                  onPressed: () => _setNewCorrectStampTime(),
                  icon: Icon(Icons.timer),
                  label: Text(
                      '${_correctStampViewModel.correctStampTime.format(context)}',
                      style: Theme.of(context).textTheme.headline)),
            ],
          ),
        )
      ],
    );
  }

  /// Set a new stamp date in [_correctStampViewModel].
  Future _setNewCorrectStampDate() async {
    final DateTime newDate = await showDatePicker(
        context: context,
        initialDate: _correctStampViewModel.correctStampDate,
        firstDate: _correctStampViewModel.correctStampDate
            .subtract(Duration(days: 365)),
        lastDate:
            _correctStampViewModel.correctStampDate.add(Duration(days: 365)),
        locale: AppLocalizations.of(context).locale);
    if (newDate != null) {
      _correctStampViewModel.correctStampDate = newDate;
    }
  }

  /// Set a new stamp time in [_correctStampViewModel].
  Future _setNewCorrectStampTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null) {
      _correctStampViewModel.correctStampTime = newTime;
    }
  }

  /// Return the right label (stamp in our out) for the change button.
  Widget _getChangeButtonLabel() {
    switch (_correctStampViewModel.timeStampType) {
      case TimeStampType.stampIn:
        return Text(
          'Einstempelzeit',
          style: Theme.of(context).textTheme.headline,
          textScaleFactor: 1.1,
        );
      case TimeStampType.stampOut:
        return Text(
          'Ausstempelzeit',
          style: Theme.of(context).textTheme.headline,
          textScaleFactor: 1.1,
        );
      default:
        return Text('unknown Type');
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
            onPressed: () async {},
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.check_circle_outline,
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
