import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/widgets/overview_view_cards.dart';

import '../../app_localizations.dart';

class HolidayView extends StatefulWidget {
  @override
  _HolidayState createState() => _HolidayState();
}

class _HolidayState extends State<HolidayView> {
  DateTime _dateFrom = new DateTime.now();
  DateTime _dateTo = new DateTime.now();
  int _dateDifference = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  //  child: _dropdownButton(),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: vacation()
                    //clockIn(),
                    ),
              ],
            ),
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.max,
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutePaths.homeView);
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
                  onPressed: () {
                    Navigator.pushNamed(context, RoutePaths.homeView);
                    print('Confirm Button was pressed');
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
          ),
        ],
      ),
    );
  }

  Widget vacation() {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: vacationWidget(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget vacationWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)
                    .translate('OVERVIEW_CARD2_VAC_APPLY_BTN'),
                style: Theme.of(context).textTheme.headline,
                textScaleFactor: 1.5,
              ),
              Text(
                AppLocalizations.of(context).translate('VAC_FROM'),
                style: Theme.of(context).textTheme.title,
                textScaleFactor: 1.3,
              ),
            ],
          ),
          FlatButton(
            onPressed: () {
              {
                _selectDateFrom(context);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${_dateFrom.day.toString()}. ${_dateFrom.month.toString()}. ${_dateFrom.year.toString()} ',
                  style: Theme.of(context).textTheme.title,
                  textScaleFactor: 1.3,
                ),
                Icon(
                  Icons.calendar_today,
                  size: 20,
                )
              ],
            ),
          ),
          Text(
            AppLocalizations.of(context).translate('VAC_TO'),
            style: Theme.of(context).textTheme.title,
            textScaleFactor: 1.3,
          ),
          FlatButton(
            onPressed: () {
              _selectDateTo(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${_dateTo.day.toString()}. ${_dateTo.month.toString()}. ${_dateTo.year.toString()}  ',
                  style: Theme.of(context).textTheme.title,
                  textScaleFactor: 1.3,
                ),
                Icon(
                  Icons.calendar_today,
                  size: 20,
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('VAC_DAYS_SUM'),
                style: Theme.of(context).textTheme.title,
                textScaleFactor: 1.3,
              ),
              Text(
                '${_dateDifferenceFunction()} days',
                style: Theme.of(context).textTheme.title,
                textScaleFactor: 1.3,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('VAC_DAYS_REMAINING'),
                style: Theme.of(context).textTheme.title,
                textScaleFactor: 1.3,
              ),
              Text(
                'Mock number of days',
                style: Theme.of(context).textTheme.title,
                textScaleFactor: 1.3,
              ),
            ],
          ),
        ]);
  }

  Future<Null> _selectDateFrom(
    BuildContext context,
  ) async {
    final DateTime pickedFrom = await showDatePicker(
      context: context,
      initialDate: _dateFrom,
      firstDate: new DateTime(2018, 10),
      lastDate: new DateTime(2021, 12),
    );

    if (pickedFrom != null && pickedFrom != _dateFrom) {
      setState(() {
        _dateFrom = pickedFrom;
      });
    }
  }

  Future<Null> _selectDateTo(
    BuildContext context,
  ) async {
    final DateTime pickedTo = await showDatePicker(
      context: context,
      initialDate: _dateTo,
      firstDate: new DateTime(2018, 10),
      lastDate: new DateTime(2021, 12),
    );
    if (pickedTo != null && pickedTo != _dateTo) {
      setState(() {
        _dateTo = pickedTo;
      });
    }
  }

  _dateDifferenceFunction() {
    return _dateDifference = _dateTo.difference(_dateFrom).inDays;
  }
}
