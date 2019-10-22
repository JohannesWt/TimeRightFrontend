import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/widgets/overview_view_cards.dart';

import '../../app_localizations.dart';

class TimeStampView extends StatefulWidget {
//  TimeStampView({@required TimeStampType timeStampType}) : _timeStampType = timeStampType;
//
//  final TimeStampType _timeStampType;

  @override
  _ClockInState createState() => _ClockInState();
}

class _ClockInState extends State<TimeStampView> {
  var _currentValueSelected = 'CLOCK_IN';

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
                  child: _dropdownButton(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: clockIn(),
                ),
              ],
            ),
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.max,
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                  onPressed: () { Navigator.pushNamed(context, RoutePaths.homeView);
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
                        style: Theme.of(context).textTheme.button, textScaleFactor: 1.2,
                      ),
                    ],
                  )),
              FlatButton(
                  onPressed: () {Navigator.pushNamed(context, RoutePaths.homeView);
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
                        style: Theme.of(context).textTheme.button,textScaleFactor: 1.2,
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget clockIn() {
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
                      child: clockInWidget(),
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
  Widget clockOut() {
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
                      child: clockOutWidget(),
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

  DropdownButton _dropdownButton() => DropdownButton<String>(
        items: [
          DropdownMenuItem(
            value: "1",
            child: Text(
              AppLocalizations.of(context).translate('CLOCK_IN'),
            ),
          ),
          DropdownMenuItem(
            value: "2",
            child: Text(
              AppLocalizations.of(context).translate('CLOCK_OUT'),
            ),
          ),
        ],
//        value: _currentValueSelected,
        onChanged: (newValueSelected) {
          setState(() {
            this._currentValueSelected = newValueSelected;
            if (newValueSelected=='CLOCK_IN'){
              clockIn();
            }
            else clockOut();
          });
        },
       // value: _currentValueSelected,
      );

  Widget clockInWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).translate('CLOCK_IN'),
            style: Theme.of(context).textTheme.headline,
            textScaleFactor: 1.3,
          ),
          Text(
            AppLocalizations.of(context).translate('CLOCK_IN_TIME'),
            style: Theme.of(context).textTheme.subhead,
            textScaleFactor: 1.2,
          ),
          Text(
            '10:33:23',
            style: Theme.of(context).textTheme.title,
            textScaleFactor: 1.2,
          ),
        ]);
  }

  Widget clockOutWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).translate('CLOCK_OUT'),
            style: Theme.of(context).textTheme.headline,
            textScaleFactor: 1.3,
          ),
          Text(
            AppLocalizations.of(context).translate('CLOCK_OUT_AT'),
            style: Theme.of(context).textTheme.subhead,
            textScaleFactor: 1.2,
          ),
          Text(
            '19:33:23',
            style: Theme.of(context).textTheme.title,
            textScaleFactor: 1.2,
          ),
        ]);
  }
}
