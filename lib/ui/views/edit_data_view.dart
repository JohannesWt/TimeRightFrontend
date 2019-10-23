import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/widgets/overview_view_cards.dart';

import '../../app_localizations.dart';

class EditDataView extends StatefulWidget {
  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditDataView> {
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();
  var _currentValueSelected;

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
                    child: addedData()
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

  Widget addedData() {
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
                      child: addedDataWidget(),
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

  Widget addedDataWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('EDIT_HOURS'),
                style: Theme.of(context).textTheme.headline,
                textScaleFactor: 1.3,
              ),
            ],
          ),
          FlatButton(
            onPressed: () {
              {
                _selectDate(context);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${_date.day.toString()}. ${_date.month.toString()}. ${_date.year.toString()} ',
                  style: Theme.of(context).textTheme.subhead,
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
                AppLocalizations.of(context).translate('CLOCK_IN_TIME'),
                style: Theme.of(context).textTheme.subhead,
                textScaleFactor: 1.3,
              ),
            ],
          ),
          FlatButton(
            onPressed: () {
              _selectTime(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${_time.format(context)}  ',
                  style: Theme.of(context).textTheme.title,
                  textScaleFactor: 1.3,
                ),
                Icon(
                  Icons.access_time,
                  size: 20,
                )
              ],
            ),
          ),
        ]);
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(2018, 10),
      lastDate: _date,
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _time);
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
      });
    }
  }
}
