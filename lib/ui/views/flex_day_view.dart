import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/viewmodels/views/flex_day_view_model.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/shared/string_formatter.dart';
import 'package:time_right/ui/views/base_widget.dart';

import '../../app_localizations.dart';

class FlexDayView extends StatefulWidget {
  FlexDayView({@required DateTime dateTime}) : _dateTime = dateTime;

  final DateTime _dateTime;

  @override
  _FlexDayState createState() => _FlexDayState();
}

class _FlexDayState extends State<FlexDayView> {
  /// Model which handles the business logic [FlexDayView].
  FlexDayViewModel _flexDayViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<FlexDayViewModel>(
      model: FlexDayViewModel(
        employeeDetailsService: Provider.of(context),
        timeStampService: Provider.of(context),
        dateTime: widget._dateTime,
      ),
      onModelReady: (model) {
        _flexDayViewModel = model;
      },
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
                        left: MediaQuery.of(context).size.width * 0.15),
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('OVERVIEW_CARD1_APPLY_FLEXTIME_BTN'),
                      style: Theme.of(context).textTheme.headline,
                      textScaleFactor: 1.1,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: _buildFlexDayForm(),
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

  /// Build flex day form where the employee can change the applied flex day.
  Widget _buildFlexDayForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('DATE'),
          style: Theme.of(context).textTheme.subhead,
          textScaleFactor: 1.1,
        ),
        FlatButton.icon(
            onPressed: () => _selectNewDate(),
            icon: Icon(Icons.calendar_today),
            label: Text(
                '${StringFormatter.getFormattedShortDateString(_flexDayViewModel.dateTime)}',
                style: Theme.of(context).textTheme.headline)),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('HOURS_APPLIED'),
                style: Theme.of(context).textTheme.subhead,
                textScaleFactor: 1.1,
              ),
              Text(
                '${_flexDayViewModel.workHours} h',
                style: Theme.of(context).textTheme.headline,
                textScaleFactor: 1.1,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('OVERVIEW_CARD1_TITLE'),
                style: Theme.of(context).textTheme.subhead,
                textScaleFactor: 1.1,
              ),
              Text(
                '${_flexDayViewModel.flexTime} h',
                style: Theme.of(context).textTheme.headline,
                textScaleFactor: 1.1,
              )
            ],
          ),
        )
      ],
    );
  }

  /// Change a new date in [_flexDayViewModel].
  Future _selectNewDate() async {
    final DateTime newDate = await showDatePicker(
        context: context,
        initialDate: _flexDayViewModel.dateTime,
        firstDate: _flexDayViewModel.dateTime.subtract(Duration(days: 365)),
        lastDate: _flexDayViewModel.dateTime.add(Duration(days: 365)));
    if (newDate != null && newDate.isAfter(DateTime.now())) {
      _flexDayViewModel.dateTime = newDate;
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

  /// Build button bar with the cancel and confirm button.
  Widget _buildButtonBar() {
    return ButtonBar(
      mainAxisSize: MainAxisSize.max,
      alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutePaths.homeView);
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
              await _flexDayViewModel.stampFlexDay().then((value) {
                Navigator.pushNamed(context, RoutePaths.homeView,
                    arguments: _flexDayViewModel.employeeDetails);
                print('Confirm Button was pressed');
              }).catchError((error) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Stempelfehler'),
                        content: Text('Nicht mehr genug Überstunden'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('ok'),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      );
                    });
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
