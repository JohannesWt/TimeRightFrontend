import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/widgets/overview_view_cards.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../app_localizations.dart';

class FlexDayView extends StatefulWidget {
  @override
  _FlexDayState createState() => _FlexDayState();
}

class _FlexDayState extends State<FlexDayView> {
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();
  bool _inputIsValid = true;
  String titleValue = '';

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
                    child: flexDay()
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

  Widget flexDay() {
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
                      child: flexDayWidget(),
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

  Widget flexDayWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('OVERVIEW_CARD1_APPLY_FLEXTIME_BTN'),
                style: Theme.of(context).textTheme.headline,
                textScaleFactor: 1.3,
              ),
              Text(
                AppLocalizations.of(context).translate('DATE'),
                style: Theme.of(context).textTheme.headline,
                textScaleFactor: 1.3,
              )
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
                AppLocalizations.of(context).translate('HOURS_APPLIED'),
                style: Theme.of(context).textTheme.title,
                textScaleFactor: 1.3,
              ),
              editHours(),
            ],
          ),
          FlatButton(
            onPressed: () { print('Edit button was pressed');

            //  Text(titleValue);
              //_selectTime(context);
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
                  Icons.mode_edit,
                  size: 20,
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('OVERVIEW_CARD1_TITLE'),
                style: Theme
                    .of(context)
                    .textTheme
                    .title,
                textScaleFactor: 1.3,
              ),
              Text(
                'Mock hours worked',
                style: Theme
                    .of(context)
                    .textTheme
                    .title,
                textScaleFactor: 1.3,
              ),

            ],

          ),
        ]);
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(2018, 10),
      lastDate: new DateTime(2021, 12),
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
  editHours() {
    TextField(
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.display1,
        decoration: InputDecoration(
          labelText: 'Enter working hours:',
          errorText:
          _inputIsValid ? null : 'Please enter a double value',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        onSubmitted: (String val) {
          Fluttertoast.showToast(msg: 'You entered: ${int.parse(val)}');
        },
        onChanged: (String val) {
          setState(() {
            titleValue= val;
          });
        }
    );
  }
}
